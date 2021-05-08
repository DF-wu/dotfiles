#!/usr/bin/fish

# Fish greet
function greet_title
    set system_logo ($HOME/Scripts/os-logo.sh)
    set greet_msg (printf "%s \033[1;32m%s \033[1;36m%s \033[1;37m%s \033[0m" $system_logo (uname -rn) (date +"%r") (uptime -p))
    echo $greet_msg
end

function fish_greeting
    printf "%s\n%s\n" (greet_title) (awk -f $HOME/Scripts/color-bar.awk)
end

# Spark for clear
alias clear='/usr/bin/env clear; seq 1 (tput cols) | sort -R | spark | lolcat -t'
function fish_user_key_bindings
    set clrStr 'clear; echo; echo; commandline -f repaint'
    if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]
        # set clrStr 'clear; echo; echo; echo; commandline -f repaint'
        set clrStr '/usr/bin/env clear; greet_title; echo; echo; echo; commandline -f repaint'
    end
    bind \cl $clrStr 
end

# Bass
bass source /etc/profile
bass source $HOME/.alias_profile
bass source $HOME/.env_profile

# Init conda if exist
if [ -f $HOME/miniconda3/bin/conda ]
    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    eval $HOME/miniconda3/bin/conda "shell.fish" "hook" $argv | source
    # <<< conda initialize <<<
end

# Env vars
set -U FZF_LEGACY_KEYBINDINGS 0

# Fish colors
set fish_color_normal brcyan
set fish_color_autosuggestion '#7d7d7d'
set fish_color_command brgreen
set fish_color_error red
set fish_color_param brcyan


# Init Starship
starship init fish | source
