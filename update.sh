#!/bin/bash

function print_status() {
    echo "$(tput setaf 2)==>$(tput bold) $1$(tput sgr0)"
}

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

print_status "SUCCESS"

defaults write com.apple.dock persistent-apps -array
for dockItem in /Applications/{"Signal","Thunderbird","Firefox","IntelliJ IDEA CE","Fork","iTerm"}.app; do
  defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>'$dockItem'</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
done
killall Dock
