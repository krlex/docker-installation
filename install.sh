#!/usr/bin/env bash
#docker-machine(){
#    curl -L https://github.com/docker/machine/releases/download/v0.16.2/docker-machine-`uname -s`-`uname -m` >/tmp/docker-machine &&
#    chmod +x /tmp/docker-machine &&
#    sudo cp /tmp/docker-machine /usr/local/bin/docker-machine
#}

pip_installation() {
  $SUDO pip3 install pip --upgrade
  $SUDO pip3 install -U docker-compose
}

install_alpine313() {
  $SUDO apk upate
  $SUDO apk add docker

  echo " Docker is ready for Alpine"
  echo " Starting installation docker-compose"
  $SUDO apk add py3-pip
  pip_installation
  echo " Finished docker-compose installation"

}

install_arch() {
  $SUDO pacman -Syu
  $SUDO pacman -S docker

  echo " Docker is ready for Arch"
  echo " Starting installation docker-compose"
  $SUDO pacman -S python-pip
  pip_installation
  echo " Finished docker-compose installation"
#  docker-machine  

}

install_debian() {
  $SUDO apt update
  $SUDO apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common curl
  curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

  $SUDO add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"


  $SUDO apt update
  $SUDO apt install -y docker-ce docker-ce-cli containerd.io
  $SUDO apt clean

  echo " Docker is ready for Debian"
  echo " Starting installation docker-compose"
  $SUDO apt install -y python3-pip
  pip_installation
  echo " Finished docker-compose installation"
  echo " Start installation docker-machine"
#  docker-machine  

}

install_ubuntu() {
  $SUDO apt update
  $SUDO apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common curl
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

  $SUDO add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

  $SUDO apt update
  $SUDO apt install -y docker-ce docker-ce-cli containerd.io
  $SUDO apt clean

  echo " Docker is ready for Ubuntu"
  echo " Starting installation docker-compose"
  $SUDO apt install -y python3-pip
  pip_installation
  echo " Finished docker-compose installation"
  echo " Start installation docker-machine"
#  docker-machine  

}

install_fedora() {
  $SUDO dnf update -y
  $SUDO dnf -y install dnf-plugins-core
  $SUDO dnf config-manager \
    --add-repo \
    https://download.docker.com/linux/fedora/docker-ce.repo

  $SUDO dnf makecache
  $SUDO dnf update
  $SUDO dnf config-manager --set-enabled docker-ce-nightly
  $SUDO dnf -y install docker-ce docker-ce-cli containerd.io

  echo " Docker is ready for Fedora"
  echo " Starting installation docker-compose"
  $SUDO dnf -y install python3-pip.noarch
  pip_installation
  echo " Finished docker-compose installation"
  echo " Start installation docker-machine"
#  docker-machine  

}

install_centos() {
  $SUDO yum update -y
  $SUDO yum install -y yum-utils

  $SUDO yum update
  $SUDO yum-config-manager --enable docker-ce-nightly
  $SUDO yum -y install docker-ce docker-ce-cli containerd.io

  echo " Docker is ready for CentOS"
  echo " Starting installation docker-compose"
  $SUDO yum install -y python3-pip.noarch
  pip_installation
  echo " Finished docker-compose installation"
  echo " Start installation docker-machine"
#  docker-machine  

}

install_amazon() {
  $SUDO yum update -y
  $SUDO amazon-linux-extras install -y docker 
  $SUDO systemctl enable docker
  $SUDO service docker start

  echo " Docker is ready for Amazon Linux"
  echo " Starting installation docker-compose"
  $SUDO yum install -y python3-pip.noarch
  pip_installation
  $SUDO ln -s /usr/local/bin/docker-compose /bin/docker-compose
  echo " Finished docker-compose installation"
  echo " Start installation docker-machine"
#  docker-machine  

}

usage() {
  echo
  echo "Linux distribution not detected"
  echo "Use: ID=[amazon|arch|alpine|ubuntu|debian|centos|fedora]"
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
        'amzn')
                install_amazon
        ;;
        'alpine')
                install_alpine313
        ;;
        'arch')
                install_arch
        ;;
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
