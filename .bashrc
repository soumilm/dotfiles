source $HOME/dotfiles/.bashrc.d/basics.sh

# All my aliases and exports
source $HOME/dotfiles/.bashrc.d/prompt.sh
source $HOME/dotfiles/.bashrc.d/aliases.sh
source $HOME/dotfiles/.bashrc.d/exports.sh

case "$(uname -sr)" in
   Darwin*)
     source $HOME/dotfiles/.bashrc.d/work.sh # this file intentionally not checked in
     source $HOME/dotfiles/.bashrc.d/macos.sh
     ;;

   Linux*)
     source $HOME/dotfiles/.bashrc.d/ubuntu.sh
     ;;

   *)
     echo 'OS unknown'
     ;;
esac

source $HOME/dotfiles/.bashrc.d/misc.sh
