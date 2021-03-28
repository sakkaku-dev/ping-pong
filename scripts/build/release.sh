#!/bin/sh

#godot --export "Windows" ./build/win/main.exe
#godot --export "Linux" ./build/linux/main.x86_64
godot --export "HTML5" ./build/web/index.html

CURRENT_BRANCH="$(git branch --show-current)"
if git checkout gh-pages; then
    cp ./build/web/* .
    git add -u

    if git commit -m 'Deploy via script'; then
        git push
    fi

    git checkout $CURRENT_BRANCH
fi