FROM phusion/baseimage
MAINTAINER Fedele Mantuano "mantuano.fedele@gmail.com"
ENV STORM_VER="1.1.1"
ENV REFRESHED_AT="2017-12-09" \
    STORM_PATH="/opt/apache-storm-${STORM_VER}"
LABEL storm_version=${STORM_VER} \
    description="Apache Storm: zookeeper, nimbus, ui, supervisor" \
    repository_url="https://github.com/fedelemantuano/apache-storm-dockerfile"
CMD ["/sbin/my_init"]
RUN mkdir -p /etc/service/zookeeperd \
    && mkdir -p /etc/service/nimbus \
    && mkdir -p /etc/service/supervisor \
    && mkdir -p /etc/service/ui \
    && mkdir -p /mnt/storm \
    && apt-get -yqq update \
    && apt-get -yqq upgrade -o Dpkg::Options::="--force-confold" \
    && apt-get -yqq --no-install-recommends install \
        curl \
        openjdk-9-jre \
        python \
        zookeeperd \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get -yqq autoremove \
    && dpkg -l | grep ^rc | awk '{print $2}' | xargs dpkg --purge \
    && curl -o ${STORM_PATH}.tar.gz http://mirror.nohup.it/apache/storm/apache-storm-${STORM_VER}/apache-storm-${STORM_VER}.tar.gz \
    && tar -zxf ${STORM_PATH}.tar.gz -C /opt \
    && rm -f ${STORM_PATH}.tar.gz \
    && mkdir -p usr/lib/jvm/java-9-openjdk-amd64/conf/management \
    && ln -s /etc/java-9-openjdk/management/management.properties /usr/lib/jvm/java-9-openjdk-amd64/conf/management/management.properties
COPY run/zookeeperd.sh /etc/service/zookeeperd/run
COPY run/nimbus.sh /etc/service/nimbus/run
COPY run/supervisor.sh /etc/service/supervisor/run
COPY run/ui.sh /etc/service/ui/run
COPY run/logviewer.sh /etc/service/logviewer/run
COPY zookeeper/zoo.cfg /etc/zookeeper/conf/zoo.cfg
COPY storm/storm.yaml $STORM_PATH/conf/storm.yaml
COPY logrotate.d/* /etc/logrotate.d/
EXPOSE 8080 8000
