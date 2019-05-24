mkdir volume
docker run \
	-it \
	--rm \
	-p 8182:8182 \
	-v $PWD/volume:/opt/gremlin-server/volume \
	--name gremlin-server \
	--init \
	brugnara/gremlin-server

