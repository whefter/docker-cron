FROM ubuntu:18.04

RUN apt-get update \
    && apt-get -y install dumb-init cron \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg2 \
        software-properties-common \
    && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - \
    && add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
       $(lsb_release -cs) \
       stable" \
    && apt-get update \
    && apt-get -y install docker-ce \
    && apt-get purge -y \
        apt-transport-https \
        gnupg2 \
        software-properties-common \
    && apt-get autoremove --purge -y \
    && rm -rf /tmp/* /var/lib/apt/lists/* /var/cache/apt/*

ADD start.sh /start.sh
RUN chmod +x /start.sh

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/start.sh"]