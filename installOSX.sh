#!/bin/sh

# install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

#remove Dock Junk
dockutil --remove Siri --no-restart
dockutil --remove Launchpad --no-restart
dockutil --remove Contacts --no-restart
dockutil --remove Calendar --no-restart
dockutil --remove Notes --no-restart
dockutil --remove Reminders --no-restart
dockutil --remove Maps --no-restart
dockutil --remove Photos --no-restart
dockutil --remove Messages --no-restart
dockutil --remove FaceTime --no-restart
dockutil --remove App\ Store --no-restart
dockutil --remove News

# brew package installs
brew install zsh zsh-syntax-highlighting zsh-autosuggestions zsh-history-substring-search lf exa dockutil tmux tree git go

# brew casks

# Emacs
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
brew cask install emacs
ln -s dots/.spacemacs .spacemacs
dockutil --add /Applications/Emacs.app

# Telegram
brew cask install telegram
dockutil --add /Applications/Telegram.app

#term
brew cask install iterm2
brew tap homebrew/cask-fonts && brew cask install homebrew/cask-fonts/font-source-code-pro
ln -s dots/.zshrc .zshrc
chsh -s $(which zsh)
dockutil --add /Applications/iTerm.app

#git
git config --global user.name "Jan Lunge"
git config --global user.email "jan.lunge@lunge.de"
ssh-keygen -C "jan.lunge@lunge.de" -q -N "" -f $HOME/.ssh/id_rsa

# programming
mkdir Playground
mkdir Code

# settings

# Disable press-and-hold for keys in favor of key repeat
#defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# NO Set a blazingly fast keyboard repeat rate
#defaults write NSGlobalDomain KeyRepeat -int 5
#defaults write NSGlobalDomain InitialKeyRepeat -int 8

defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock expose-animation-duration -float 0.1

#Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0
# Remove the animation when hiding/showing the Dock
defaults write com.apple.dock autohide-time-modifier -float 0
defaults write com.apple.dock showhidden -bool true
defaults write com.apple.dock show-recents -bool false
