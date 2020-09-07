#!/usr/bin/env bash

install_debian() {
  $SUDO apt update
  $SUDO apt dist-upgrade -y --auto-remove
  $SUDO apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
  curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

  $SUDO add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"

  $SUDO apt update
  $SUDO apt install -y docker-ce docker-ce-cli containerd.io
  $SUDO apt clean

  echo " Docker is ready for Debian"

}

install_ubuntu() {
  $SUDO apt update
  $SUDO apt dist-upgrade -y --auto-remove
  $SUDO apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

  $SUDO add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

  $SUDO apt update
  $SUDO apt install -y docker-ce docker-ce-cli containerd.io
  $SUDO apt clean

  echo " Docker is ready for Ubuntu"

}

install_fedora() {
  $SUDO dnf update -y
  $SUDO dnf -y install dnf-plugins-core
  $SUDO dnf config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

  $SUDO dnf makecache
  $SUDO dnf update
  $SUDO dnf config-manager --set-enabled docker-ce-nightly
  $SUDO dnf -y install docker-ce docker-ce-cli containerd.io

  echo " Docker is ready for Fedora"

}

install_centos() {
  $SUDO yum update -y
  $SUDO yum install -y yum-utils

  $SUDO yum update
  $SUDO yum-config-manager --enable docker-ce-nightly
  $SUDO yum -y install docker-ce docker-ce-cli containerd.io

  echo " Docker is ready for CentOS"

}

usage() {
  echo
  echo "Linux distribution not detected"
  echo "Use: ID=[ubuntu|debian|centos|fedora]"
  echo "Other distribution not yet supported"
  echo

}

if [ -f /etc/os-release ]; then
  . /etc/os-release
elif [ -f /etc/debian_version ]; then
  $ID=debian
fi

if [[ $EUID -ne 0 ]]; then
  SUDO='sudo -H'
else
  SUDO=''
fi

case $ID in
        'ubuntu')
                install_ubuntu
        ;;
        'debian')
                install_debian
        ;;
        'centos')
                install_centos
        ;;
        'fedora')
                install_fedora
        ;;
        *)
          usage
        ;;
esac
