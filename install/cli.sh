# Install xcode CLI tools from the App Store
xcode-select --install

# Install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor
brew tap homebrew/services

# Install order matters
brew instal libssh2
brew install openssl
brew install curl --with-libssh2 --with-openssl
brew install git --with-curl --with-openssl

# Others
brew install youtube-dl

# Override pre-installed duplicates
brew link --force curl
