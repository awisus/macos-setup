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

persistentApps=($(defaults read com.apple.dock persistent-apps | grep -o 'file://.*;'))

print_status "GAINING GROUP OWNERSHIP"
sudo chgrp staff   /Applications/*
sudo chmod g+w     /Applications/*
echo "done."
echo ""

print_status "BREW UPGRADE"
brew upgrade --greedy --force
brew reinstall libreoffice-language-pack
brew cleanup
echo "done."
echo ""

print_status "RESET QUARANTINE FLAGS"
sudo xattr -d com.apple.quarantine /Applications/*
echo "done."
echo ""

print_status "RESET DOCK ITEMS"
restore_persistent_apps
echo "done."
echo ""

print_status "SUCCESS"
