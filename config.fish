# config.fish

set -g fish_greeting

fish_add_path -a /home/$USER/.local/bin
fish_add_path -a ~/.cargo/bin

set -g BROWSER '/usr/bin/browser_in_win'

# my aliases
alias py="python3"
alias cat="bat"
alias vim="nvim"
alias ls="exa -alFmh --group-directories-first"
alias t="~/.tmux-alias.sh"

starship init fish | source
zoxide init fish | source
