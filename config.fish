# config.fish

export PATH="$PATH:/home/pi/.local/bin"

# my aliases

alias py="python3"
# alias cat="bat"
alias vim="nvim"
# alias ls="exa -lFmh --group-directories-first"
alias ls="exa -alFmh --group-directories-first"
# alias la="exa -alFmh --group-directories-first"

starship init fish | source
