# ─── Plugins ────────────────────────────────────────────────────────────────
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ─── History ────────────────────────────────────────────────────────────────
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY

# ─── Quality of Life ────────────────────────────────────────────────────────
setopt AUTO_CD
setopt CORRECT
autoload -Uz compinit && compinit

# ─── PATH ───────────────────────────────────────────────────────────────────
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/miniconda3/bin:$PATH"
export PATH="/usr/local/go/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"
export PATH="/usr/local/oecore-x86_64/sysroots/x86_64-nilrtsdk-linux/usr/bin:$PATH"

# ─── Environment Variables ───────────────────────────────────────────────────
export BROWSER=/usr/bin/browser_in_win
export NVM_DIR="$HOME/.nvm"

# ─── NVM ────────────────────────────────────────────────────────────────────
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"

# ─── Aliases ────────────────────────────────────────────────────────────────
alias py="python3"
alias cat="bat"
alias vim="nvim"
alias ls="eza --long --all --header --group-directories-first --classify"
alias dotfiles="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias pwrs="powershell.exe -Command"
alias list-usb='powershell.exe -Command "usbipd list"'
alias attach-usb='powershell.exe -Command "usbipd attach --wsl --busid"'
alias detach-usb='powershell.exe -Command "usbipd detach --busid"'

# ─── Tmux Auto-attach ───────────────────────────────────────────────────────
if [[ -z "$TMUX" ]]; then
    tmux new-session -A -s main
fi

# ─── Conda ──────────────────────────────────────────────────────────────────
# >>> conda initialize >>>
__conda_setup="$("$HOME/miniconda3/bin/conda" 'shell.zsh' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
fi
unset __conda_setup
# <<< conda initialize <

# ─── Prompt & Tools ─────────────────────────────────────────────────────────
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
