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

# TOKYONIGHT STORM THEME

# TokyoNight Color Palette
set -l foreground c0caf5
set -l selection 364A82
set -l comment 565f89
set -l red f7768e
set -l orange ff9e64
set -l yellow e0af68
set -l green 9ece6a
set -l purple 9d7cd8
set -l cyan 7dcfff
set -l pink bb9af7

# Syntax Highlighting Colors
set -g fish_color_normal $foreground
set -g fish_color_command $cyan
set -g fish_color_keyword $pink
set -g fish_color_quote $yellow
set -g fish_color_redirection $foreground
set -g fish_color_end $orange
set -g fish_color_error $red
set -g fish_color_param $purple
set -g fish_color_comment $comment
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $green
set -g fish_color_escape $pink
set -g fish_color_autosuggestion $comment

# Completion Pager Colors
set -g fish_pager_color_progress $comment
set -g fish_pager_color_prefix $cyan
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $comment

starship init fish | source

set -gx WASMTIME_HOME "$HOME/.wasmtime"

string match -r ".wasmtime" "$PATH" > /dev/null; or set -gx PATH "$WASMTIME_HOME/bin" $PATH
# Wasmer
export WASMER_DIR="/home/pi/.wasmer"
[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"
