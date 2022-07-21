# Installation docker and docker compose for Linux OS

Sometimes i have problem to do all instructions from official site of docker for installation
Now i create this script who will recognize Linux OS and do installation and configuration

```
- Amazon Linux
- Alpine
- Arch
- Debian
- Ubuntu
- CentOS
- Fedora
```

Everything you need to do is just start the `script.sh` and script will do everythin else
Just enjoy

One-live command download and auto-start installation:
```
 bash <(curl -sL https://raw.githubusercontent.com/krlex/docker-installation/master/install.sh)
```

About Docker:

![Docker](https://avatars0.githubusercontent.com/u/5429470?s=200&v=4)
Docker is software that provides containers, which allows teams to emulate development environments. Docker began as an internal project, initially developed by dotCloud engineers.

About Docker-Compose:

![Docker Compose](https://raw.githubusercontent.com/docker/compose/master/logo.png)

Compose is a tool for defining and running multi-container Docker applications. With Compose, you use a Compose file to configure your application's services. Then, using a single command, you create and start all the services from your configuration. To learn more about all the features of Compose see the list of features.

Compose is great for development, testing, and staging environments, as well as CI workflows. You can learn more about each case in Common Use Cases.

Using Compose is basically a three-step process.

![Docker-Machine 2019](https://github.com/docker/machine/releases/tag/v0.16.2)
Machine lets you create Docker hosts on your computer, on cloud providers, and inside your own data center.
It creates servers, installs Docker on them, then configures the Docker client to talk to them.

For installation you need to uncomment docker-machine functions in `install.sh` and on OS you want to install
