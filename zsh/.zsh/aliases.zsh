case `uname` in
  Darwin)
    alias ls='/usr/local/bin/gls --color -h --group-directories-first'
  ;;
  Linux)
    alias ls='/bin/ls --color=tty --group-directories-first'
  ;;
esac
alias http='http --print=hb'
