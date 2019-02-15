# installation OSX

## fonts
`brew tap homebrew/cask-fonts && brew cask install font-source-code-pro;`

## Dock
`defaults write com.apple.Dock showhidden -bool true #set transparency`
`defaults write com.apple.dock autohide-delay -float 0;killall Dock #instant dock`
`defaults write com.apple.dock autohide-time-modifier -float 0.25;killall Dock #faster animation`

## maintainance
logfiles for terminal usage `sudo rm -rf /private/var/log/asl/*.asl` 
zsh history `mv ~/.zsh_history ~/zsh_history_backup`
