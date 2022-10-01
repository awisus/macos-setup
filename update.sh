#!/bin/zsh

function print_status() {
    echo "$(tput setaf 2)==>$(tput bold) $1$(tput sgr0)"
}

function wrap_dock_item() {
  echo '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>'$1'</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
}

function restore_persistent_apps() {
  defaults write com.apple.dock persistent-apps -array
  for dockItem in $persistentApps; do
    dockItem=$(echo $dockItem | sed "s/file:\/\///g" | sed "s/\/\";//g" | sed "s/%20/ /g")
    defaults write com.apple.dock persistent-apps -array-add "$(wrap_dock_item "$dockItem")"
  done

  killall Dock
}

if which flutter >/dev/null ; then
    print_status "UPDATING FLUTTER"
    flutter upgrade
    echo "done."
    echo ""
fi

if which rustup >/dev/null ; then
    print_status "UPDATING RUST"
    rustup update
    echo "done."
    echo ""
fi

print_status "BREW UPGRADE"
persistentApps=($(defaults read com.apple.dock persistent-apps | grep -o 'file://.*;'))
sudo chgrp staff   /Applications/*
sudo chmod g+w     /Applications/*
brew upgrade --greedy --force
brew reinstall libreoffice-language-pack
brew cleanup
sudo xattr -d com.apple.quarantine /Applications/*
restore_persistent_apps
echo "done."
echo ""

print_status "SUCCESS"
