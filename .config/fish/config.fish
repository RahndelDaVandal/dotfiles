# config.fish

set -g fish_greeting

fish_add_path -a /home/$USER/.local/bin
fish_add_path -a ~/.cargo/bin
fish_add_path -a /home/$USER/miniconda3/bin
fish_add_path -a /usr/local/go/bin
fish_add_path -a $HOME/go/bin
fish_add_path -a ~/.npm-global/bin

set -g BROWSER /usr/bin/browser_in_win
set -g NVM_DIR $HOME/.nvm
# set -g nvm_default_version '18.15.0'

# my aliases
alias py="python3"
alias cat="bat"
alias vim="nvim"
alias ls="exa -alFmh --group-directories-first"
alias dotfiles="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias pwrs="powershell.exe -Command"
alias list-usb='powershell.exe -Command "usbipd list"'
alias attach-usb='powershell.exe -Command "usbipd attach --wsl --busid"'
alias detach-usb='powershell.exe -Command "usbipd detach --busid"'

# Windows terminal command `wsl -e fish -l`
if status is-interactive
    if not set -q TMUX
        tmux new-session -A -s main
    end
end

# function t
#     if tmux ls &>/dev/null
#         tmux attach
#     else
#         tmux
#     end
# end

starship init fish | source
zoxide init fish | source

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /home/connor/miniconda3/bin/conda
    eval /home/connor/miniconda3/bin/conda "shell.fish" hook $argv | source
end
# <<< conda initialize <<<
