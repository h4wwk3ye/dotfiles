#!/bin/zsh

# Ascii art using https://onlineasciitools.com/convert-text-to-ascii-art
cat << "EOF"
   _____      _   _   _               _    _         __  __             ____      
  / ____|    | | | | (_)             | |  | |       |  \/  |           / __ \     
 | (___   ___| |_| |_ _ _ __   __ _  | |  | |_ __   | \  / | __ _  ___| |  | |___ 
  \___ \ / _ \ __| __| | '_ \ / _` | | |  | | '_ \  | |\/| |/ _` |/ __| |  | / __|
  ____) |  __/ |_| |_| | | | | (_| | | |__| | |_) | | |  | | (_| | (__| |__| \__ \
 |_____/ \___|\__|\__|_|_| |_|\__, |  \____/| .__/  |_|  |_|\__,_|\___|\____/|___/
                               __/ |        | |                                   
                              |___/         |_|                                                                                                                                       
  ______ ______ ______ ______ ______ ______ ______ ______ ______ ______ ______ ______  
 |______|______|______|______|______|______|______|______|______|______|______|______|
  ______ ______ ______ ______ ______ ______ ______ ______ ______ ______ ______ ______ 
 |______|______|______|______|______|______|______|______|______|______|______|______|
                                                                                                      
EOF

###############################################################################################

cat << "EOF"
 ___                                 _                  __        
  |  ._   _ _|_  _. | | o ._   _    / \ |_    |\/|       /  _ |_  
 _|_ | | _>  |_ (_| | | | | | (_|   \_/ | |   |  | \/   /_ _> | | 
                               _|                  /              
EOF
# Check for Oh My Zsh and install if we don't have it
if [[ ! $(which omz) ]] then
	/bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
else
	echo "\nOh my zsh already installed\n"
fi

###############################################################################################

cat << "EOF"
 ___                                                                 
  |  ._   _ _|_  _. | | o ._   _    |_|  _  ._ _   _  |_  ._ _       
 _|_ | | _>  |_ (_| | | | | | (_|   | | (_) | | | (/_ |_) | (/_ \/\/ 
                               _|                                                                  
EOF
# Check for Homebrew and install if we don't have it
if [[ ! $(which brew) ]] then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
	echo "\nHomebrew already installed\n"
fi

###############################################################################################

cat << "EOF"
 ___                                 _                                    _     
  |  ._   _ _|_  _. | | o ._   _    |_) _        _  ._ |  _      _  | /| / \ |  
 _|_ | | _>  |_ (_| | | | | | (_|   |  (_) \/\/ (/_ |  | (/_ \/ (/_ |  | \_/ |< 
                               _|                                                                        
EOF
# Install powerlevel10k - https://github.com/romkatv/powerlevel10k
powerLevel10kFolder=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
powerLevel10kUrl=https://github.com/romkatv/powerlevel10k.git
if [[ ! -d "$powerLevel10kFolder" ]]; then
	echo "Downloading powerlevel10k\n"
	git clone --depth=1 $powerLevel10kUrl $powerLevel10kFolder
else
	echo "powerlevel10k already installed, updating it\n"
	cd "$powerLevel10kFolder"
	git pull $powerLevel10kUrl
fi

###############################################################################################

cat << "EOF"
 ___                                                                                    
  |  ._   _ _|_  _. | | o ._   _     /\  ._  ._   _        _ o ._   _    |_  ._ _       
 _|_ | | _>  |_ (_| | | | | | (_|   /--\ |_) |_) _>   |_| _> | | | (_|   |_) | (/_ \/\/ 
                               _|        |   |                      _|                                    
EOF
# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle --file=$HOME/.dotfiles/Brewfile

###############################################################################################

cat << "EOF"
  _                                                      _                     _          
 /  ._ _   _. _|_ o ._   _     _    ._ _  | o ._  |    _|_ _  ._    _  _  ._ _|_ o  _   _ 
 \_ | (/_ (_|  |_ | | | (_|   _> \/ | | | | | | | |<    | (_) |    (_ (_) | | |  | (_| _> 
                         _|      /                                                  _|                              
EOF

checkSymlink() {
	if [[ -L $1 ]]; then
		echo 1
		return
	fi
	echo 0
}

createSymLink() {
	ln -sv $1 $2
}

# Hashtable to map source links to destination
declare -A configLocation
configLocation[$HOME/.dotfiles/.zshrc]=$HOME/.zshrc
configLocation[$HOME/.dotfiles/git]=$HOME/.config/git
configLocation[$HOME/.dotfiles/.gitconfig]=$HOME/.gitconfig
configLocation[$HOME/.dotfiles/customScripts]=$HOME/.config/customScripts
configLocation[$HOME/.dotfiles/limelight]=$HOME/.config/limelight
configLocation[$HOME/.dotfiles/skhd]=$HOME/.config/skhd
configLocation[$HOME/.dotfiles/yabai]=$HOME/.config/yabai
configLocation[$HOME/.dotfiles/.p10k.zsh]=$HOME/.p10k.zsh
configLocation[$HOME/.dotfiles/.vim_runtime]=$HOME/.vim_runtime
configLocation[$HOME/.dotfiles/.vimrc]=$HOME/.vimrc
configLocation[$HOME/.dotfiles/karabiner/karabiner.json]=$HOME/.config/karabiner/karabiner.json

# Removes directories if they exist and are not symlinked. Then create symlinks from the .dotfiles
for key value in ${(kv)configLocation}; do
    if [[ $(checkSymlink $value) -eq "0" ]]; then
    	rm -rf $value
    	createSymLink $key $value
    fi
done

###############################################################################################

cat << "EOF"
  __                                                             __         _  
 (_ _|_  _. ._ _|_ o ._   _    \_/ _. |_   _. o    _. ._   _|   (_  |/ |_| | \ 
 __) |_ (_| |   |_ | | | (_|    | (_| |_) (_| |   (_| | | (_|   __) |\ | | |_/ 
                          _|                                                   
EOF

if [[ $(brew services list | grep skhd | awk '{print $2}') == "started" ]]; then
    echo "SKHD already running"
else
    brew services start skhd
fi


if [[ $(brew services list | grep yabai | awk '{print $2}') == "started" ]]; then
    echo "Yabai already running"
else
    brew services start yabai
fi

cat << "EOF"
 ___                                 _ __  _ 
  |  ._   _ _|_  _. | | o ._   _    |_  / |_ 
 _|_ | | _>  |_ (_| | | | | | (_|   |  /_ |  
                               _|            
EOF

$(brew --prefix)/opt/fzf/install --all

# Source zshrc
source ~/.zshrc
