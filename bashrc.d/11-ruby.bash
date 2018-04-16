########
# Ruby #

[[ -s /usr/local/opt/chruby/share/chruby/chruby.sh ]] && \
  source /usr/local/opt/chruby/share/chruby/chruby.sh
[[ -s /usr/local/opt/chruby/share/chruby/auto.sh ]] && \
  source /usr/local/opt/chruby/share/chruby/auto.sh

# OS X has its own way of setting LANG, but only at the console.
# By declaring here in .bashrc, daemons like Pow will also pick it up.
export LANG=en_US.UTF-8

# Enable auto-discovery of appropriate gem versions by inspecting the
# Gemfile.lock in the working directory tree. Requires RubyGems >= 2.2.0.
# http://guides.rubygems.org/command-reference/#gem-dependency-files
# export RUBYGEMS_GEMDEPS=-

# added by travis gem
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh
