for file in ~/.{aliases,paths}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

source ~/.git-completion.bash
