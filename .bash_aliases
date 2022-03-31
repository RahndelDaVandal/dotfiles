# bash_aliases

# my aliases

alias cat="bat"                       
alias vim="nvim"             
alias ls="exa -lFmh --group-directories-first"
alias la="exa -alFmh --group-directories-first"                
                                                                   
# Python venv alias                                             
venv_alias(){                                       
  if [[ $VIRTUAL_ENV ]]; then
      deactivate                       
    else
    source .venv/bin/activate                           
  fi                                                                
}                                                              
alias venv=venv_alias                                         
alias kali="docker restart kali && docker attach kali" 
