FROM alpine:latest

RUN apk add --no-cache \
    # Common tools
    bash docker-cli curl dumb-init flock rsync wget openssh

ADD start.sh /start.sh
RUN chmod +x /start.sh

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/start.sh"]
