#!/bin/bash

rm -rf $HOME/.jenv

export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

jenv add /Library/Java/JavaVirtualMachines/adoptopenjdk-11.jdk/Contents/Home/
jenv global 11.0
jenv enable-plugin gradle
jenv enable-plugin maven
