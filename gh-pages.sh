#!/bin/bash
set -e

# compile
elm make src/Main.elm

# remove index.html from .gitignore
# compatible with both GNU and BSD/Mac sed
sed -i.bak '/index.html/d' .gitignore
rm .gitignore.bak

echo "ls"
ls

# init branch and commit
git init
git config user.name "Trevor Rothaus (via Travis CI)"
git config user.email "trotha01@gmail.com"
git checkout -b gh-pages
git add .
git status
git commit -m "Deploy to GitHub Pages [skip ci]"
git push --force "https://${GITHUB_TOKEN}@github.com/trotha01/elm-snake.git" gh-pages
