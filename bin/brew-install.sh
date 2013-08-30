#!/bin/bash

set -e

for tap in completions dupes versions; do
  brew tap homebrew/$tap
done

formulae=(
"dos2unix --enable-nls" argyll bash-completion colordiff ctags-exuberant
curl-ca-bundle django-completion git graphviz grep hub libyaml macvim mercurial
multimarkdown mysql node postgresql python python25 python26 qt s3cmd
sleepwatcher ssh-copy-id swig terminal-notifier tree wdiff wget
)

for formula in ${formulae[@]}; do
  brew install $formula
done

brew update && brew upgrade && brew cleanup

brew unlink python && brew link python
