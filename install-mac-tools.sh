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
brew_install "golangci-lint"
brew_install "clang-format"
brew_install "keepassxc" "--cask"
brew_install "imagemagick"
brew_install "lua"
brew_install "luarocks"
brew_install "fzf"
brew_install "zoxide"
brew_install "act"
brew_install "qmk/qmk/qmk"
brew_install "ngrok/ngrok/ngrok"
brew_install "slack" "--cask"
brew_install "pipx"
brew_install "btop"

### yazi
brew_install "yazi"
brew_install "ffmpegthumbnailer"
brew_install "unar"
brew_install "jq"
brew_install "poppler"
brew_install "fd"
brew_install "ripgrep"
brew_install "fzf"
brew_install "zoxide"
brew_install "font-symbols-only-nerd-font"

### Finishing fzf install
$(brew --prefix)/opt/fzf/install

### Rust (for `cargo`)
curl --proto "=https" --tlsv1.2 -sSf https://sh.rustup.rs | sh

cargo install stylua
cargo install bob-nvim

bob install stable # or use `nightly if stable < 0.10.0`

### Go DAP
go install github.com/go-delve/delve/cmd/dlv@lates

### Go tools
go install github.com/a-h/templ/cmd/templ@latest
go install github.com/air-verse/air@latest
go install honnef.co/go/tools/cmd/staticcheck@latest

### Prettierd
npm install -g @fsouza/prettierd

### Luarocks testing framework
luarocks install --local busted

### Harlequin SQL IDE
pipx install harlequin[postgres]
## if fail
# pipx inject harlequin harlequin-postgres
pipx ensurepath

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
add_to_zshrc 'eval "$(zoxide init zsh)"' "### zoxide"
add_to_zshrc "export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --color=fg:#6e7681,hl:#ffffff --color=fg+:#c9d1d9,bg+:#1e4273,hl+:#fdac54 --color=info:#d29922,prompt:#58a6ff,pointer:#a371f7 --color=marker:#ec8e2c,spinner:#6e7681,header:#343941'" "### fzf theme"
add_to_zshrc 'export BAT_THEME="github_dark_colorblind_custom"' "### bat theme"

### AVR + Embedded
brew tap osx-cross/avr

brew_install "avr-gcc"
brew_install "avrdude"
brew_install "arduino-cli"

### Fun stuff
brew_install "steam" "--cask"

### Oh-my-zsh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

### ZSH goodies
git clone https://github.com/jeffreytse/zsh-vi-mode ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-vi-mode
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autocomplete
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

### Adding .bash_aliases
add_to_zshrc "if [ -f $HOME/.bash_aliases ]; then" "### Adding .bash_aliases"
add_to_zshrc ". $HOME/.bash_aliases"
add_to_zshrc "fi"

### Custom scripts runs
add_to_zshrc "if [ -f $HOME/scripts/scripts.sh ]; then" "### Scripts autorun"
add_to_zshrc ". $HOME/scripts/scripts.sh"
add_to_zshrc "fi"
