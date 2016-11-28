
function get_git_status -d "Gets the current git status"
  if command git rev-parse --is-inside-work-tree >/dev/null 2>&1
    set -l dirty (command git status -s --ignore-submodules=dirty | wc -l | sed -e 's/^ *//' -e 's/ *$//' 2> /dev/null)
    set -l ref (command git describe --tags --exact-match ^/dev/null ; or command git symbolic-ref --short HEAD 2> /dev/null ; or command git rev-parse --short HEAD 2> /dev/null)

    if [ "$dirty" != "0" ]
      set_color -b normal
      set_color blue
      echo "✚ $dirty"
      echo " "
      set_color -b black
      set_color purple
      echo ""
      set_color -b purple
      set_color black
      echo " ⎇  $ref "
    end
    set_color normal
   end
end

function fish_right_prompt -d "Prints right prompt"
  get_git_status
end
