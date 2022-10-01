#!/bin/bash

rm -rf $HOME/.jenv

export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

jenv add /Library/Java/JavaVirtualMachines/temurin-25.jdk/Contents/Home/
jenv global 25.0
jenv enable-plugin gradle
jenv enable-plugin maven
jenv enable-plugin export
