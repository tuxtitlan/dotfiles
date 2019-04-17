# pyenv
hash pyenv 2>/dev/null && eval "$(pyenv init -)"

# virtualenv
export WORKON_HOME=$HOME/.virtualenvs
hash pyenv 2>/dev/null && pyenv virtualenvwrapper_lazy

# pip
export PIP_REQUIRE_VIRTUALENV=true

syspip() {
  PIP_REQUIRE_VIRTUALENV="" pip "$@"
}

# pipenv
hash pipenv 2>/dev/null && eval "$(pipenv --completion)"
