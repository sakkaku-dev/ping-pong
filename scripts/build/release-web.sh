#!/bin/sh

# Web version only works if exported from inside the godot engine
git clone --branch gh-pages git@github.com:sakkaku-dev/ping-pong.git gh-pages
cp ./build/web/* gh-pages -R
cd gh-pages
git add -A
git commit -m 'Deploy via script'
git push