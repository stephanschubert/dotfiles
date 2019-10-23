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
brew install emojify
brew install gnu-tar
brew install wget

# Override pre-installed duplicates
brew link --force curl

brew install git-secrets
# Run in every repo
# git secrets --install
# git secrets --register-aws

brew install tree

brew tap cantino/mcfly https://github.com/cantino/mcfly
brew install mcfly

pip install --upgrade pip
# Required for `subfont`
pip install fonttools brotli zopfli
