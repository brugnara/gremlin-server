
## TL;DR;

> start gremlin with persistance

Graph will be saved in the `volume` folder when you will stop the container.

```bash
mkdir volume
docker run \
	-d \
	--rm \
	-p 8182:8182 \
	-v $PWD/volume:/opt/gremlin-server/volume \
	--name gremlin-server \
	--init \
	brugnara/gremlin-server

```

## Stop the container

> The stop will trigger the save on disk

```bash
docker stop gremlin-server
```

## Build from repo, then start as a daemon

> Check start.sh if you don't need daemon.

```bash
docker build -t brugnara/gremlin-server:3.3.3 . 
bash daemon.sh 
docker logs -f gremlin-server
```

## Persistance

Gremlin saves on disk, in the `volume` folder, the graph, just before a shutdown:

```bash
docker stop gremlin-server
ls -lah volume/
total 12K
drwxr-xr-x 2 root root 4,0K mag 21 12:05 .
drwxrwxr-x 4 vrut vrut 4,0K mag 21 12:08 ..
-rw-r--r-- 1 root root   90 mag 21 12:05 graph.json
```
