#!/bin/sh

#godot --export "Windows" ./build/win/main.exe
#godot --export "Linux" ./build/linux/main.x86_64
godot --export "HTML5" ./build/web/index.html

if git checkout gh-pages; then
    cp ./build/web/* .
    git add -u

    git commit -m 'Deploy via script'
    git push
fi