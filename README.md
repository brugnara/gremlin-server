
## First start

```
docker build -t brugnara/gremlin-server:3.3.3 . 
bash daemon.sh 
docker logs -f gremlin-server
```

## Persistance

Gremlin saves on disk, in the `volume` folder, the graph, just before a shutdown:

```
docker stop gremlin-server
ls -lah volume/
total 12K
drwxr-xr-x 2 root root 4,0K mag 21 12:05 .
drwxrwxr-x 4 vrut vrut 4,0K mag 21 12:08 ..
-rw-r--r-- 1 root root   90 mag 21 12:05 graph.json
```
