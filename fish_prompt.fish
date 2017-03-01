## Function to show a segment
function prompt_segment -d "Function to show a segment"
  # Get colors
  set -l bg $argv[1]
  set -l fg $argv[2]

  # Set 'em
  set_color -b $bg
  set_color $fg

  # Print text
  if [ -n "$argv[3]" ]
    echo -n -s $argv[3]
  end
end

## Function to show current status
function show_status -d "Function to show the current status"
  if [ $RETVAL -ne 0 ]
    prompt_segment FDAE66 D52116 " ✖ "
    if [ -n "$SSH_CLIENT" ]
      prompt_segment 8FE9FC FDAE66 ""
      prompt_segment 8FE9FC 444759 " SSH: "
      prompt_segment AF8EF9 8FE9FC ""
    else
      prompt_segment AF8EF9 FDAE66 ""
    end
  end
end

# Show directory
function show_pwd -d "Show the current directory"
  set -l pwd (prompt_pwd)
  prompt_segment AF8EF9 282A36 " $pwd "
  prompt_segment 5F63AB AF8EF9 ""
  prompt_segment normal 5F63AB ""
end

# Show virtualenv
# function show_virtualenv -d "Show active python virtual environments"
#   if set -q VIRTUAL_ENV
#     set -l venvname (basename "$VIRTUAL_ENV")
#     prompt_segment AF8EF9 282A36 " $pwd "
#     prompt_segment normal green "($venvname) "
#   end
# end

# Show prompt w/ privilege cue
function show_prompt -d "Shows prompt with cue for current priv"
  if test -e .ruby-version
    set -l ruby_version (rbenv version | awk '{print $1}')
    prompt_segment normal red " ∴ $ruby_version"
    prompt_segment normal white " →"
  end
  prompt_segment normal white " "
  set_color normal
end

## SHOW PROMPT
function fish_prompt
  set -g RETVAL $status
  show_status
  show_pwd
  # show_virtualenv
  show_prompt
  if [ "$TMUX" != "" ]
    eval $HOME/.bubu/tmux-gitbar/update-gitbar
  end
end
