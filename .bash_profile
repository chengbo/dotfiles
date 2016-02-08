for file in ~/.{aliases,paths,bash_prompt}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;
