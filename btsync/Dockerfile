FROM ubuntu:14.04.1

ADD http://download-new.utorrent.com/endpoint/btsync/os/linux-x64/track/stable /bitsync/btsync.tar.gz
RUN tar xf /bitsync/btsync.tar.gz && \
    rm /bitsync/btsync.tar.gz && \
	useradd btsync --home /bitsync

ADD start.bash /start.bash
WORKDIR /bitsync

VOLUME ["/btsync-override"]

CMD ["bash", "/start.bash"]

EXPOSE 3369/udp
