# config.fish
# set fish_greeting ""

fish_add_path -a /home/pi/.local/bin
fish_add_path -a /usr/local/go/bin
fish_add_path -a ~/.cargo/bin
fish_add_path -a /sbin
fish_add_path -a /usr/sbin

# export PATH="$PATH:/home/pi/.local/bin"
# export PATH="$PATH:/usr/local/go/bin"
# export PATH="$PATH:~/.cargo/bin"

zoxide init fish | source

# my aliases
alias t="~/tmux-alias.sh"

alias cp="cp -i"
alias rm="rm -i"
alias mv="mv -i"
alias pytest="py -m pytest"
alias py="python3.10"
alias cat="bat"
alias vim="nvim"
# alias ls="exa -alFmh --group-directories-first"
# alias ls="exa -alFmhs modified --group-directories-first"
alias ls="exa -alFmhs name --group-directories-first"
# alias find="fd"
alias grep="rg"
alias du="dust"
# alias time="hyperfine"
alias ps="procs"
# alias sed="sd"
# alias top="btm"
# alias htop="btm"

alias led-on="echo \"1\" > /proc/net/rtl88XXau/wlan1/led_ctrl"
alias led-off="echo \"0\" > /proc/net/rtl88XXau/wlan1/led_ctrl"

starship init fish | source

set -gx WASMTIME_HOME "$HOME/.wasmtime"

string match -r ".wasmtime" "$PATH" > /dev/null; or set -gx PATH "$WASMTIME_HOME/bin" $PATH
# Wasmer
export WASMER_DIR="/home/pi/.wasmer"
[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"
