#!/bin/zsh

echo "Setting up MacOS\n"

# Check for Oh My Zsh and install if we don't have it
if [[ ! $(which omz) ]] then
	/bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
else
	echo "\nOh my zsh already installed\n"
fi

# Check for Homebrew and install if we don't have it
if [[ ! $(which brew) ]] then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
	echo "\nHomebrew already installed\n"
fi

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle

# Removes directories if they exist and symlinks them file from the .dotfiles

rm -rf $HOME/.zshrc
ln -sv $HOME/.dotfiles/.zshrc $HOME/.zshrc
echo "Symlinked zshrc"

rm -rf $HOME/.config/git
ln -sv $HOME/.dotfiles/git $HOME/.config/git
echo "Symlinked git excludes"

rm -rf $HOME/.gitconfig
ln -sv $HOME/.dotfiles/.gitconfig $HOME/.gitconfig
echo "Symlinked git config"

rm -rf $HOME/.config/customScripts
ln -sv $HOME/.dotfiles/customScripts $HOME/.config/customScripts
echo "Symlinked customScripts for skhd and yabai"

rm -rf $HOME/.config/limelight
ln -sv $HOME/.dotfiles/limelight $HOME/.config/limelight
echo "Symlinked limelight config"

rm -rf $HOME/.config/skhd
ln -sv $HOME/.dotfiles/skhd $HOME/.config/skhd
echo "Symlinked skhd config"

rm -rf $HOME/.config/yabai
ln -sv $HOME/.dotfiles/yabai $HOME/.config/yabai
echo "Symlinked yabai config"
