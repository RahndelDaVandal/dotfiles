# Dotfiles
## Tutorial link
https://mjones44.medium.com/storing-dotfiles-in-a-git-repository-53f765c0005d
## Alias Needed
`alias dotfiles="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"`
## Install Script
```
#!/usr/bin/env bashgit clone --bare git@github.com:mrjones2014/dotfiles.git $HOME/.dotfiles# define config alias locally since the dotfiles
# aren't installed on the system yet
function config {
   git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}# create a directory to backup existing dotfiles to
mkdir -p .dotfiles-backup
config checkout
if [ $? = 0 ]; then
  echo "Checked out dotfiles from git@github.com:mrjones2014/dotfiles.git";
  else
    echo "Moving existing dotfiles to ~/.dotfiles-backup";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
fi# checkout dotfiles from repo
config checkout
config config status.showUntrackedFiles no
```
`curl https://raw.githubusercontent.com/mrjones2014/dotfiles/master/scripts/config-init | bash`
