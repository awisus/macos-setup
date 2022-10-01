#!/bin/bash

rm -rf $HOME/flutter

git clone https://github.com/flutter/flutter.git -b stable $HOME/flutter

$HOME/flutter/bin/flutter precache
$HOME/flutter/bin/flutter config --enable-macos-desktop
