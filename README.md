# Installation

```
$ git clone git://github.com/sevos/duddet.git
$ cd duddet
$ bundle
$ librarian-puppet install
$ vagrant up

$ vagrant ssh duddet-bakery

duddet-bakery $ duddet build docker-registry
duddet-bakery $ docker run -d duddet-bakery:5000/docker-registry
duddet-bakery $ curl duddet-bakery:5000
"docker-registry server (dev)"
```