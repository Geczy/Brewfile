#!/bin/sh

set -e
set -u

repository=$HOME/Documents/github/Brewfile

cd "$repository"
rm Brewfile || true
brew bundle dump -f
npm list --global --parseable --depth=0 | sed '1d' | awk '{gsub(/\/.*\//,"",$1); print}' >npm-global-list
yarn global list --depth=0 | sed '1d' | awk '{gsub(/@.*$/,"",$1); print}' >yarn-global-list
git add .
git commit -m "Backup Brewfile $(date "+%Y-%m-%d %H:%M:%S")"
git push origin master
osascript -e 'display notification "Finish backing up  Brewfile" with title "Brewfile"'
