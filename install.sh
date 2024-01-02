#!/bin/zsh

# xcode
if [ ! -d /Applications/Xcode.app ] ; then
  echo "install xcode first"
  exit 1
fi

sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -runFirstLaunch
sudo softwareupdate --install-rosetta

# apps
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

brew tap heroku/brew && brew install heroku
brew install colima
brew install docker
brew install docker-buildx
brew install docker-compose
brew install fzf
brew install git
brew install git-delta
brew install gradle
brew install jenv
brew install kubectl
brew install lazygit
brew install maven
brew install neovim
brew install rg
brew install tmux
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

brew tap homebrew/cask-versions
brew install --cask temurin17
brew install --cask amethyst
brew install --cask appcleaner
brew install --cask bitwarden
brew install --cask caffeine
brew install --cask chromedriver
brew install --cask firefox
brew tap homebrew/cask-fonts
brew install --cask font-fira-code
brew install --cask font-fira-code-nerd-font
brew install --cask fork
brew install --cask gimp
brew install --cask google-drive
brew install --cask gpg-suite
brew install --cask hiddenbar
brew install --cask homebrew/cask-drivers/steelseries-exactmouse-tool
brew install --cask intellij-idea-ce
brew install --cask iterm2
brew install --cask insomnia
brew install --cask libreoffice
brew install --cask libreoffice-language-pack
brew install --cask minecraft
brew install --cask nvidia-geforce-now
brew install --cask proxy-audio-device
brew install --cask signal
brew install --cask thunderbird

bash tools/flutter.sh
bash tools/jenv.sh
bash tools/node.sh
bash tools/tmux.sh
bash tools/zsh.sh

# docker
mkdir -p ~/.docker/cli-plugins
ln -sfn $(brew --prefix)/opt/docker-compose/bin/docker-compose ~/.docker/cli-plugins/docker-compose
ln -sfn $(brew --prefix)/opt/docker-buildx/bin/docker-buildx   ~/.docker/cli-plugins/docker-buildx
colima start --cpu 5 --memory 8 --disk 64 --kubernetes

# config
mkdir -p android
mkdir -p flutter
chflags hidden android
chflags hidden flutter
touch $HOME/.hushlogin
cp update.sh $HOME/.local/bin/update
chmod +x     $HOME/.local/bin/update
cp tms.sh    $HOME/.local/bin/tms
chmod +x     $HOME/.local/bin/tms

defaults write NSGlobalDomain KeyRepeat -int 1
defaults write com.apple.dock tilesize -int 48
defaults write com.apple.dock orientation left
defaults write com.apple.dock mineffect -string scale
defaults write com.apple.dock show-recents -bool no
defaults write com.apple.dock persistent-apps -array
for dockItem in /Applications/{"Signal","Firefox","Brave Browser","Thunderbird","Fork","IntelliJ IDEA CE","iTerm","NVIDIA GeForce NOW"}.app; do
  defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>'$dockItem'</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
done
killall Dock

git config --global color.ui true
git config --global pull.rebase true
git config --global user.name "Jens Awisus"
git config --global user.email "awisus.jens@gmail.com"

# manual steps
echo "Installation abgeschlossen!"
echo "Noch zu installieren: pcloud"
