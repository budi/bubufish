## SHOW A SEGMENT
function prompt_segment -d "Function to show a segment"
  set -l bg $argv[1]
  set -l fg $argv[2]
  set_color -b $bg
  set_color $fg
  if [ -n "$argv[3]" ]
    echo -n -s $argv[3]
  end
end

## SHOW CURRENT STATUS
function show_status -d "Function to show the current status"
  if [ $RETVAL -ne 0 ]
    prompt_segment FDAE66 D52116 " ✖ "
    if [ -n "$SSH_CLIENT" ]
      prompt_segment 8FE9FC FDAE66 ""
      prompt_segment 8FE9FC 444759 " SSH: "
      prompt_segment AF8EF9 8FE9FC ""
    else if set -q VIRTUAL_ENV
      prompt_segment 61E47D FDAE66 ""
    else
      prompt_segment AF8EF9 FDAE66 ""
    end
  end
end

## SHOW VIRTUALENV
function show_virtualenv -d "Show active python virtual environments"
  set -gx VIRTUAL_ENV_DISABLE_PROMPT "true"
  if set -q VIRTUAL_ENV
    set -l venvname (basename "$VIRTUAL_ENV")
    prompt_segment 61E47D 282A36 " $venvname "
    prompt_segment AF8EF9 61E47D ""
  end
end

## SHOW DIRECTORY
function show_pwd -d "Show the current directory"
  set -l pwd (prompt_pwd)
  prompt_segment AF8EF9 282A36 " $pwd "
  prompt_segment 5F63AB AF8EF9 ""
  prompt_segment normal 5F63AB ""
end

## SHOW PROMPT W/ PRIVILEGE CUE
function show_prompt -d "Shows prompt with cue for current priv"
  if test -e .ruby-version
    set -l ruby_version (rbenv version | awk '{print $1}')
    prompt_segment normal red " ∴ $ruby_version"
    prompt_segment normal white " →"
  end
  prompt_segment normal white " "
  set_color normal
end

## SHOW PROMPT RESULT
function fish_prompt
  set -g RETVAL $status
  show_status
  show_virtualenv
  show_pwd
  show_prompt
  if [ "$TMUX" != "" ]
    eval $HOME/.bubu/tmux-gitbar/update-gitbar
  end
end
