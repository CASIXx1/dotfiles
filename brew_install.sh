#!/bin/sh -eu

echo "\nbrew updating...\n"
brew update

echo "\nbrew pin...\n"
brew pin mysql

echo "\nbrew upgrading...\n"
brew upgrade

echo "\nbrew installing...\n"
brew bundle

echo "\nbrew cleanuping...\n"
brew cleanup
