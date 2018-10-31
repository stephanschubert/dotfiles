export HOMEBREW_CASK_OPTS="--appdir=/Applications"

brew cask install 1password
brew cask install alfred
brew cask install flux
brew cask install google-chrome
brew cask install google-chrome-canary
brew cask install kap
brew cask install karabiner-elements

# Quick Look plugins -- https://github.com/sindresorhus/quick-look-plugins
brew cask install betterzip
brew cask install qlcolorcode
brew cask install qlimagesize
brew cask install qlmarkdown
brew cask install qlprettypatch
brew cask install qlstephen
brew cask install qlvideo
brew cask install quicklook-json
brew cask install quicklook-pat
brew cask install quicklookase
brew cask install suspicious-package
brew cask install webpquicklook

# Settings for Quick Look plugins
defaults write org.n8gray.QLColorCode font "Fira Code"
defaults write org.n8gray.QLColorCode fontSizePoints 8
defaults write org.n8gray.QLColorCode hlTheme github
defaults write org.n8gray.QLColorCode extraHLFlags '--replace-tabs=2'
qlmanage -r
