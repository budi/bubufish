# TMUX
function tmd
  if tmux has-session -t default
    tmux attach-session -t default
  else
    tmux new-session -s default
  end
end
alias tml "tmux list-session"
function tmk
  if [ "$TMUX" != "" ]
    tmux kill-session -t (tmux display-message -p '#S')
  end
end
alias tmn "tmux new -s"
alias tma "tmux attach-session -t"
