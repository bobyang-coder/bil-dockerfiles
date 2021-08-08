#!/bin/sh
# 1.定义
redis_image='redis:5.0.2'
container_name='redis-'
network_name=''

# 2.获取redis所有节点的container_id
container_id_list=`docker ps -q  --filter "name=$container_name"`

# 3.获取集群ip
cluster_hosts=''
for container_id in $container_id_list
do
# 3.1获取容器ip
host_ip=`docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $container_id`
# 3.1获取network名字
network_name=`docker inspect --format='{{.HostConfig.NetworkMode}}' $container_id`
echo ">>>>>>>>容器id:$container_id,network:$network_name,ip:$host_ip"
cluster_hosts="$cluster_hosts $host_ip:6379 ";
done

# 4创建集群
echo ">>>>>>>>集群hosts  $cluster_hosts"
echo ">>>>>>>>creating cluster...."
echo 'yes' | docker run -i --rm --net $network_name $redis_image redis-cli --cluster create $cluster_hosts --cluster-replicas 1;


