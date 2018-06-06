[![Build Status](https://travis-ci.org/fedelemantuano/apache-storm-dockerfile.svg?branch=master)](https://travis-ci.org/fedelemantuano/apache-storm-dockerfile)
[![](https://images.microbadger.com/badges/image/fmantuano/apache-storm.svg)](https://microbadger.com/images/fmantuano/apache-storm "Get your own image badge on microbadger.com")

# apache-storm-dockerfile

**apache-storm-dockerfile** is a dockerfile to build [fmantuano/apache-storm](https://hub.docker.com/r/fmantuano/apache-storm/) Docker image.

**fmantuano/apache-storm** is an all-in-one [Apache Storm](http://storm.apache.org/) image that allows you to run a container with:
  - Zookeeper
  - Nimbus
  - Supervisor
  - Storm UI on port 8080
  - Storm logviewer on port 8000


To use it, create a new instance as usual:

```
$ sudo docker run --name storm -p 8000:8000 -d fmantuano/apache-storm
```

Once the docker instance is created, you can control it by running:

```
$ sudo docker start storm

$ sudo docker stop storm
```

To exec an interactive shell:

```
$ sudo docker exec -ti storm /bin/bash
```
