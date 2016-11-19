FROM phusion/baseimage
MAINTAINER Fedele Mantuano "mantuano.fedele@gmail.com"
ENV STORM_VER="1.0.2"
ENV REFRESHED_AT="2016-11-19" \
    STORM_PATH="/opt/apache-storm-${STORM_VER}"
LABEL storm_version=${STORM_VER} \
    description="Apache Storm: zookeeper, nimbus, ui, supervisor" \
    repository_url="https://github.com/fedelemantuano/apache-storm-dockerfile"
RUN mkdir -p /var/log/supervisor \
    && apt-get -yqq update \
    && apt-get -yqq install \
        curl \
        openjdk-8-jre \
        python \
        supervisor \
        zookeeperd \
    && rm -rf /var/lib/apt/lists/*
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY zookeeper/zoo.cfg /etc/zookeeper/conf/zoo.cfg
RUN curl -o ${STORM_PATH}.tar.gz http://mirror.nohup.it/apache/storm/apache-storm-${STORM_VER}/apache-storm-${STORM_VER}.tar.gz \
    && tar -zxf ${STORM_PATH}.tar.gz -C /opt \
    && rm -f ${STORM_PATH}.tar.gz
COPY storm/storm.yaml $STORM_PATH/conf/storm.yaml
ENTRYPOINT ["/usr/bin/supervisord"]
EXPOSE 8080
