# pyenv
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

# virtualenv
export WORKON_HOME=$HOME/.virtualenvs

# pip
export PIP_REQUIRE_VIRTUALENV=true

syspip() {
  PIP_REQUIRE_VIRTUALENV="" pip "$@"
}

# pipenv
eval "$(pipenv --completion)"
