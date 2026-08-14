PROMPT='%m %B%F{blue}:: %b$(toon) %F{green}$(git_worktree_prompt_path) $(hg_prompt_info)%B%(!.%F{red}.%F{blue})»%f%b '
RPS1='%(?..%F{red}%? ↵%f)'

# Nerd Font Font Awesome "apple" brand glyph (nf-fa-apple, U+F179).
# Unlike the bundled "apple" theme's U+F8FF (an Apple-system-font-only
# private-use codepoint), this one is bundled in every Nerd Font.
function toon {
  echo -n ""
}

ZSH_THEME_HG_PROMPT_PREFIX="%{$fg[magenta]%}hg:‹%{$fg[yellow]%}"
ZSH_THEME_HG_PROMPT_SUFFIX="%{$fg[magenta]%}› %{$reset_color%}"
ZSH_THEME_HG_PROMPT_DIRTY=" %{$fg[red]%}✗"
ZSH_THEME_HG_PROMPT_CLEAN=""

# Outside a git repo, falls back to "%3~" (the theme's normal truncated
# path), which is then expanded as a prompt escape since oh-my-zsh sets
# PROMPT_SUBST.
git_worktree_prompt_path() {
  local common_dir repo_name branch

  common_dir=$(git rev-parse --path-format=absolute --git-common-dir 2>/dev/null) || {
    print -n '%3~'
    return
  }

  if [[ "$(basename -- "$common_dir")" == ".git" ]]; then
    repo_name=$(basename -- "$(dirname -- "$common_dir")")
  else
    repo_name=$(basename -- "$common_dir")
  fi

  branch=$(git symbolic-ref --short HEAD 2>/dev/null) || branch=$(git rev-parse --short HEAD 2>/dev/null)

  print -n "${repo_name}/${branch}"
}
