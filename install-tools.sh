#!/bin/bash

# @see https://apple.stackexchange.com/a/425118
brew_install() {
    echo "\nInstalling $1"
    if brew list $1 &>/dev/null; then
        echo "${1} is already installed"
    else
        brew install $2 $1 && echo "$1 is installed"
    fi
}

mv Colemak\ DH.bundle /Library/Keyboard\ Layouts

bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew tap cask/versions

brew_install "firefox" "--cask"
brew_install "firefox-developer-edition" "--cask"
brew_install "google-chrome" "--cask"
brew_install "opera" "--cask"
brew_install "visual-studio-code" "--cask"
brew_install "postman" "--cask"
brew_install "github" "--cask"
brew_install "docker" "--cask"
brew_install "linear-linear" "--cask"
brew_install "iterm2" "--cask"
brew_install "figma" "--cask"
brew_install "spotify" "--cask"
brew_install "karabiner-elements" "--cask"
brew_install "rectangle" "--cask"
brew_install "android-file-transfer" "--cask"
brew_install "flux" "--cask"
brew_install "notion" "--cask"
brew_install "slack" "--cask"
brew_install "1password" "--cask"
brew_install "discord" "--cask"

### AVR
brew tap osx-cross/avr

brew_install "avr-gcc"
brew_install "avrdude"
