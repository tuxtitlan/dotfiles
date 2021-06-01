#!/usr/bin/env bash
set -e

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y gdebi \
  ufw \
  gufw \
  chrome-gnome-shell \
  chromium-browser \
  gdebi \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg-agent \
  software-properties-common \
  gnome-tweaks \
  arc-theme \
  git \
  build-essential \
  libsecret-1-0 \
  libsecret-1-dev \
  htop \
  ubuntu-mate-wallpapers-photos \
  ruby \
  libnss3-tools \
  libmemcached-dev \
  libxmlsec1 \
  openssl \
  sqlite3 \
  xz-utils \
  zlib1g \
  vim \
  openvpn \
  network-manager-openvpn \
  network-manager-openvpn-gnome \
  exuberant-ctags \
  tree \
  neofetch

echo "Installing pyenv dependencies"
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
  libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
  xz-utils tk-dev libffi-dev liblzma-dev python-openssl git libedit-dev

echo "Adding MS VSCode repo"
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

echo "Adding Paper icons PPA"
sudo add-apt-repository -u ppa:snwh/ppa -y

echo "Adding Typora repo"
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys BA300B7755AFCFAE
sudo add-apt-repository -y 'deb https://typora.io/linux ./'

echo "Adding Docker repo"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository -y \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
	$(lsb_release -cs) \
	stable"

echo "Adding Insomnia REST repo"
wget --quiet -O - https://insomnia.rest/keys/debian-public.key.asc |
  sudo apt-key add -
echo "deb https://dl.bintray.com/getinsomnia/Insomnia /" |
  sudo tee -a /etc/apt/sources.list.d/insomnia.list

echo "Adding Peek PPA"
sudo add-apt-repository -y ppa:peek-developers/stable

echo "Adding Go PPA"
sudo add-apt-repository -y ppa:longsleep/golang-backports

echo "Installing Spotify"
curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

echo "Installing APT packages"
sudo apt-get update
sudo apt-get install -y code \
  paper-icon-theme \
  typora \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  insomnia \
  peek \
  spotify-client

echo "Docker post-install"
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
docker run hello-world

echo "Installing Slack"
curl https://downloads.slack-edge.com/linux_releases/slack-desktop-4.3.2-amd64.deb

echo "Installing Sentry CLI"
curl -sL https://sentry.io/get-cli/ | bash
sentry-cli login

echo "Installing Heroku CLI"
curl https://cli-assets.heroku.com/install-ubuntu.sh | sh
heroku login

echo "Installing NVM"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash
nvm install --lts

echo "Installing AWS CLI"
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm awscliv2.zip
rm -Rf ./aws

echo "Installing ctop"
sudo wget https://github.com/bcicen/ctop/releases/download/v0.7.3/ctop-0.7.3-linux-amd64 -O /usr/local/bin/ctop
sudo chmod +x /usr/local/bin/ctop

echo "Installing ultrahook"
sudo gem install ultrahook

echo "Installing pyenv"
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

echo "Installing docker-compose"
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
