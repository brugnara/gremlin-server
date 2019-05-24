FROM tinkerpop/gremlin-server:3.3

WORKDIR /opt/gremlin-server

ADD tinkergraph-empty.properties conf/tinkergraph-empty.properties
ADD trapper.sh /trapper.sh

VOLUME ["/opt/gremlin-server/volume"]

ENTRYPOINT ["/trapper.sh"]
