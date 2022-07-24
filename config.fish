# config.fish
# set fish_greeting ""

fish_add_path -a /home/pi/.local/bin
fish_add_path -a /usr/local/go/bin
fish_add_path -a ~/.cargo/bin

# export PATH="$PATH:/home/pi/.local/bin"
# export PATH="$PATH:/usr/local/go/bin"
# export PATH="$PATH:~/.cargo/bin"

zoxide init fish | source

# my aliases

alias cp="cp -i"
alias rm="rm -i"
alias mv="mv -i"
alias pytest="py -m pytest"
alias py="python3.10"
alias cat="bat"
alias vim="nvim"
alias ls="exa -alFmh --group-directories-first"
alias find="fd"
alias grep="rg"
alias du="dust"
# alias time="hyperfine"
alias ps="procs"
alias sed="sd"
alias top="btm"
alias htop="btm"

starship init fish | source
