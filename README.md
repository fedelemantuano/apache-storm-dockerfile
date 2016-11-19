[![](https://images.microbadger.com/badges/image/fmantuano/storm.svg)](https://microbadger.com/images/fmantuano/storm  "fmantuano/storm badge on microbadger.com ")

# apache-storm-dockerfile

**apache-storm-dockerfile** is a dockerfile to build [fmantuano/storm](https://hub.docker.com/r/fmantuano/storm/) Docker image.
For defaults I used [defaults.yaml](https://github.com/apache/storm/blob/v0.9.5/conf/defaults.yaml), with some changes.

**fmantuano/storm** is an all-in-one [Apache Storm](http://storm.apache.org/) image that allows you to run a container with:
  - Zookeeper
  - Nimbus
  - Supervisor
  - Storm UI on port 8080
  - Storm logviewer on port 8000


To use it, create a new instance as usual:

```
$ sudo docker run --name storm -p 8080:8080 -p 8000:8000 -d fmantuano/storm
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
