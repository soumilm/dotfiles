source $HOME/dotfiles/.zshrc.d/basics.zsh

# All my aliases and exports
source $HOME/dotfiles/.zshrc.d/exports.zsh
source $HOME/dotfiles/.zshrc.d/aliases.zsh
source $HOME/dotfiles/.zshrc.d/prompt.zsh

case "$(uname -sr)" in
   Darwin*)
     # source $HOME/dotfiles/.zshrc.d/work.zsh # this file intentionally not checked in
     source $HOME/dotfiles/.zshrc.d/macos.zsh
     ;;

   Linux*)
     source $HOME/dotfiles/.zshrc.d/ubuntu.zsh
     ;;

   *)
     echo 'OS unknown'
     ;;
esac

source $HOME/dotfiles/.zshrc.d/misc.zsh
