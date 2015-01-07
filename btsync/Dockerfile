FROM ubuntu:14.04.1

ADD http://download-new.utorrent.com/endpoint/btsync/os/linux-x64/track/stable /btsync.tar.gz
RUN tar xf /btsync.tar.gz && \
    rm /btsync.tar.gz

ADD start.sh /start.sh

VOLUME ["/data"]
VOLUME ["/config"]

EXPOSE 3369/udp

CMD ["/start.sh"]
