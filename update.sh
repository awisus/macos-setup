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
