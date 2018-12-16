#!/bin/sh
# 查看集群中各节点的状态
# 带表头docker ps --format "table {{.ID}}\t{{.Names}}"
set -e

for container_id in $(docker ps -a -q --filter "ancestor=zookeeper")  
do   
echo "==========================================="
# docker exec -it  $container_id zkServer.sh $1;
docker exec -it  $container_id zkServer.sh status;
done