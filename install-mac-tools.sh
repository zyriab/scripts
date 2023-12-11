#!/bin/bash

if [ -z "${BASH_VERSION:-}" ]
then
  abort "Bash is required to interpret this script."
fi

# @see https://apple.stackexchange.com/a/425118
brew_install() {
    echo "Installing $1"
    if brew list $1 &>/dev/null; then
        echo "${1} is already installed"
    else
        brew install $2 $1 && echo "$1 is installed"
    fi
}

### Keeb layout
curl -L https://github.com/ColemakMods/mod-dh/archive/refs/heads/master.zip --output keeb-layout.zip
unzip keeb-layout.zip
sudo mv mod-dh-master/macOS/Colemak\ DH.bundle /Library/Keyboard\ Layouts

echo "Colemak-DH ISO installed. You must restart and add it to the input sources. :)"

### 0h-my-zsh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

### Brew
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> $HOME/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

### General env
brew tap homebrew/cask-versions

brew_install "firefox" "--cask"
brew_install "firefox-developer-edition" "--cask"
brew_install "google-chrome" "--cask"
brew_install "opera" "--cask"
brew_install "visual-studio-code" "--cask"
brew_install "postman" "--cask"
brew_install "github" "--cask"
brew_install "docker" "--cask"
brew_install "figma" "--cask"
brew_install "spotify" "--cask"
brew_install "karabiner-elements" "--cask"
brew_install "rectangle" "--cask"
brew_install "android-file-transfer" "--cask"
brew_install "flux" "--cask"
brew_install "notion" "--cask"
brew_install "1password" "--cask"
brew_install "discord" "--cask"
brew_install "coteditor" "--cask"
brew_install "gh"
brew_install "neovim"

### AVR + Embedded
brew tap osx-cross/avr

brew_install "avr-gcc"
brew_install "avrdude"
brew_install "arduino-cli"

### Fun stuff

brew_install "steam" "--cask"
