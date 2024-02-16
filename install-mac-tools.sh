#!/bin/bash

if [ -z "${BASH_VERSION:-}" ]
then
  abort "Bash is required to interpret this script."
fi

# @see https://apple.stackexchange.com/a/425118
brew_install() {
    echo "Installing $1"
    if brew list $1 &>/dev/null; then
        echo "$1 is already installed"
    else
        brew install "$2" "$1" && echo "$1 is installed"
    fi
}

add_to_zshrc() {
    local zshrc_path=${ZDOTDIR:-$HOME}/.zshrc

    if [ -n $2 ]; then
        echo "$2" >> $zshrc_path
    fi

    echo "$1" >> $zshrc_path
}

### Keeb layout
curl -L https://github.com/ColemakMods/mod-dh/archive/refs/heads/master.zip --output keeb-layout.zip
unzip keeb-layout.zip
sudo mv mod-dh-master/macOS/Colemak\ DH.bundle /Library/Keyboard\ Layouts

echo "Colemak-DH ISO installed. You must restart and add it to the input sources. :)"


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
# brew_install "notion" "--cask"
# brew_install "1password" "--cask"
brew_install "discord" "--cask"
brew_install "coteditor" "--cask"
brew_install "gh"
brew_install "wezterm" "--cask"
brew_install "node"
brew_install "wget"
brew_install "ripgrep"
brew_install "fd"
brew_install "go"
brew_install "lazygit"
brew_install "zsh-autocomplete"
brew_install "zsh-autosuggestions"
brew_install "zsh-syntax-highlighting"
brew_install "golangci-lint"
brew_install "clang-format"
brew_install "keepassxc" "--cask"
brew_install "imagemagick"
brew_install "lua"
brew_install "luarocks"

### Rust (for `cargo`)
curl --proto "=https" --tlsv1.2 -sSf https://sh.rustup.rs | sh

cargo install stylua
cargo install bob-nvim

bob install stable # or use `nightly if stable < 0.10.0`

### Go DAP
go install github.com/go-delve/delve/cmd/dlv@lates

### Luarocks testing framework
luarocks install --local busted

### Finishing Colemak setup
mkdir -p $HOME/.config/karabiner && cp ./karabiner/* $HOME/.config/karabiner 

### Adding undercurl support for WezTerm + Neovim
tempfile=$(mktemp) \
  && curl -o $tempfile https://raw.githubusercontent.com/wez/wezterm/master/termwiz/data/wezterm.terminfo \
  && tic -x -o ~/.terminfo $tempfile \
  && rm $tempfile

add_to_zshrc "export EDITOR=nvim"
add_to_zshrc "export TERM=wezterm"
add_to_zshrc 'export BOB_CONFIG="$HOME/.config/bob/config.toml"' "### Neovim w/ Bob as version manager"
add_to_zshrc 'export PATH="$PATH:$HOME/.local/share/bob/nvim-bin"'
add_to_zshrc 'export GOPATH="$HOME/go"' "### Go"
add_to_zshrc 'export PATH="$PATH:$GOPATH/bin"'
add_to_zshrc 'export PATH="$PATH:$HOME/.cargo/bin"' "### Rust"
add_to_zshrc 'export PATH="$PATH:$HOME/.luarocks/bin"' "### Luarocks"

### AVR + Embedded
brew tap osx-cross/avr

brew_install "avr-gcc"
brew_install "avrdude"
brew_install "arduino-cli"

### Fun stuff
brew_install "steam" "--cask"

### 0h-my-zsh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

### ZSH goodies
# FIXME: need to see if it's needed on Linux + double-check everything is there if it's in fact needed
# add_to_zshrc "source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
# add_to_zshrc "source $(brew --prefix)/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh"
# add_to_zshrc "source $(brew --prefix)/share/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

### Adding .bash_aliases
add_to_zshrc "if [ -f $HOME/.bash_aliases ]; then" "### Adding .bash_aliases"
add_to_zshrc ". $HOME/.bash_aliases"
add_to_zshrc "fi"

### Custom scripts runs
add_to_zshrc "if [ -f $HOME/scripts/scripts.sh ]; then" "### Scripts autorun"
add_to_zshrc ". $HOME/scripts/scripts.sh"
add_to_zshrc "fi"
