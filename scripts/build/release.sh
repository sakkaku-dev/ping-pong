#!/bin/sh

godot --export "Windows" ./build/win/main.exe
godot --export "Linux" ./build/linux/main.x86_64
godot --export "HTML5" ./build/web/index.html

git checkout gh-pages
cp ./build/web/* .
git add -u

git commit -m 'Deploy via script'
git push