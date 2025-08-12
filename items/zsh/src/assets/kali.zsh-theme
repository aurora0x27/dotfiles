# ---------------------------- Kali Prompt--------------------------------
# TODO: Too long, how to write a shorter prompt?
prompt_symbol=@
PROMPT=$'
%F{%(#.blue.green)}┌──${debian_chroot:+($debian_chroot)─}${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))─}(%B%F{%(#.red.blue)}%n'$prompt_symbol$'%m%b%F{%(#.blue.green)})─[%B%F{reset}%(6~.%-1~/…/%4~.%5~)%b%F{%(#.blue.green)}]$(git_prompt_info) $(git_remote_status)\n└─%B%(#.%F{red}#.%F{blue}$)%b%F{reset} '

ZSH_THEME_GIT_PROMPT_PREFIX="-<%{$reset_color%}%{$fg[white]%}%{$fg_bold[blue]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}%{$fg[green]%}>"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}x%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE="%{$fg_bold[magenta]%}↓%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE="%{$fg_bold[magenta]%}↑%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE="%{$fg_bold[magenta]%}↕%{$reset_color%}"

unset prompt_symbol
# ---------------------------- Kali Prompt--------------------------------
