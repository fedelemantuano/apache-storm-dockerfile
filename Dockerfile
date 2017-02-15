FROM phusion/baseimage
MAINTAINER Fedele Mantuano "mantuano.fedele@gmail.com"
ENV STORM_VER="1.0.3"
ENV REFRESHED_AT="2017-02-15" \
    STORM_PATH="/opt/apache-storm-${STORM_VER}"
LABEL storm_version=${STORM_VER} \
    description="Apache Storm: zookeeper, nimbus, ui, supervisor" \
    repository_url="https://github.com/fedelemantuano/apache-storm-dockerfile"
CMD ["/sbin/my_init"]
RUN mkdir -p /etc/service/zookeeperd \
    && mkdir -p /etc/service/nimbus \
    && mkdir -p /etc/service/supervisor \
    && mkdir -p /etc/service/ui \
    && apt-get -yqq update \
    && apt-get -yqq upgrade -o Dpkg::Options::="--force-confold" \
    && apt-get -yqq --no-install-recommends install \
        curl \
        openjdk-8-jre \
        python \
        zookeeperd \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get -yqq autoremove \
    && dpkg -l | grep ^rc | awk '{print $2}' | xargs dpkg --purge \
    && curl -o ${STORM_PATH}.tar.gz http://mirror.nohup.it/apache/storm/apache-storm-${STORM_VER}/apache-storm-${STORM_VER}.tar.gz \
    && tar -zxf ${STORM_PATH}.tar.gz -C /opt \
    && rm -f ${STORM_PATH}.tar.gz
COPY run/zookeeperd.sh /etc/service/zookeeperd/run
COPY run/nimbus.sh /etc/service/nimbus/run
COPY run/supervisor.sh /etc/service/supervisor/run
COPY run/ui.sh /etc/service/ui/run
COPY zookeeper/zoo.cfg /etc/zookeeper/conf/zoo.cfg
COPY storm/storm.yaml $STORM_PATH/conf/storm.yaml
EXPOSE 8080
