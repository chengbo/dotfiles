---@param solutions string[]
---@return string?
local function shallowest_solution(solutions)
    table.sort(solutions, function(left, right)
        local left_depth = #vim.split(vim.fs.dirname(left), "/", { plain = true, trimempty = true })
        local right_depth = #vim.split(vim.fs.dirname(right), "/", { plain = true, trimempty = true })
        return left_depth < right_depth
    end)

    return solutions[1]
end

return {
    -- Use Microsoft's Roslyn language server instead of LazyVim's OmniSharp-based
    -- .NET extra. Keeping this plugin startup-loaded ensures it can register the
    -- LSP before the first C# buffer is opened; the plugin itself is very small.
    {
        "seblyng/roslyn.nvim",
        ---@module "roslyn.config"
        ---@type RoslynNvimConfig
        opts = {
            -- Roslyn's native watcher is more efficient than forwarding every change
            -- through Neovim on large repositories. Unlike "off", this still notices
            -- project and generated-file changes made outside Neovim.
            filewatching = "roslyn",
            -- Avoid recursively searching every child directory for solutions.
            broad_search = false,
            -- When nested solutions overlap, prefer the solution closest to the
            -- workspace root rather than a narrower solution in a child directory.
            choose_target = shallowest_solution,
        },
        init = function()
            -- mason-lspconfig automatically enables installed servers. Explicitly
            -- disable its C# servers so roslyn.nvim is the only C# LSP owner.
            vim.lsp.enable("omnisharp", false)
            vim.lsp.enable("roslyn_ls", false)

            -- If a project is not listed in a solution, roslyn.nvim normally falls
            -- back to the project directory. Give it the shallowest solution found
            -- above the file as a generic workspace-root fallback.
            local group = vim.api.nvim_create_augroup("roslyn_solution_fallback", { clear = true })
            vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
                group = group,
                pattern = "*.cs",
                callback = function(event)
                    local directory = vim.fs.dirname(vim.fs.abspath(event.file))
                    local solutions = vim.fs.find(function(name)
                        local extension = vim.fs.ext(name)
                        return extension == "sln" or extension == "slnx" or extension == "slnf"
                    end, { path = directory, upward = true, limit = math.huge })
                    local solution = shallowest_solution(solutions)
                    if solution then
                        vim.g.roslyn_nvim_selected_solution = vim.fs.abspath(solution)
                    end
                end,
            })

            vim.lsp.config("roslyn", {
                settings = {
                    ["csharp|background_analysis"] = {
                        dotnet_analyzer_diagnostics_scope = "openFiles",
                        dotnet_compiler_diagnostics_scope = "openFiles",
                    },
                    ["csharp|formatting"] = {
                        dotnet_organize_imports_on_format = true,
                    },
                },
            })
        end,
    },

    {
        "mason-org/mason.nvim",
        opts = {
            registries = {
                "github:mason-org/mason-registry",
                -- roslyn-language-server, versioned to match the VS Code C# extension
                "github:Crashdummyy/mason-registry",
            },
            ensure_installed = {
                "html-lsp",
                "roslyn-language-server",
                "netcoredbg",
            },
        },
    },

    -- roslyn.nvim forwards the HTML portions of Razor/Blazor documents to this
    -- server. It is only active for HTML (including Roslyn's virtual HTML files).
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                html = {},
                -- Both packages may remain installed in Mason, but LazyVim must not
                -- configure or automatically enable them for C# buffers.
                omnisharp = { enabled = false },
                roslyn_ls = { enabled = false },
            },
        },
    },

    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = { "c_sharp" },
        },
    },

    -- Keep debugging lazy-loaded through LazyVim's DAP extra. No test discovery
    -- or solution scanning happens until a debug session is explicitly started.
    {
        "mfussenegger/nvim-dap",
        optional = true,
        opts = function()
            local dap = require("dap")

            dap.adapters.netcoredbg = {
                type = "executable",
                command = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg",
                args = { "--interpreter=vscode" },
                options = { detached = false },
            }

            dap.configurations.cs = {
                {
                    type = "netcoredbg",
                    name = "Launch .NET assembly",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopAtEntry = false,
                },
                {
                    type = "netcoredbg",
                    name = "Attach to .NET process",
                    request = "attach",
                    processId = require("dap.utils").pick_process,
                },
            }
        end,
    },
}
