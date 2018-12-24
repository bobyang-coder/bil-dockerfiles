# 集群启动脚本
# 参考链接：https://simplydistributed.wordpress.com/2018/08/31/redis-5-bootstrapping-a-redis-cluster-with-docker/
# 基础配置
start_cmd='redis-server --cluster-enabled yes --cluster-config-file nodes.conf --cluster-node-timeout 5000 --appendonly yes'
redis_image='redis:5.0.2'
network_name='redis_cluster_net'

docker network create $network_name
echo $network_name " created"

# 启动节点
for port in `seq 8001 8006`; do \
 docker run -d --name "redis-"$port -p $port:6379 --net $network_name $redis_image $start_cmd;
 echo "created redis cluster node redis-"$port
done

# 构建集群
cluster_hosts=''

for port in `seq 8001 8006`; do \
 hostip=`docker inspect -f '{{(index .NetworkSettings.Networks "redis_cluster_net").IPAddress}}' "redis-"$port`;
 echo "IP for cluster node redis-"$port "is" $hostip
 cluster_hosts="$cluster_hosts $hostip:6379 ";
done

echo "cluster hosts "$cluster_hosts
echo "creating cluster...."
echo 'yes' | docker run -i --rm --net $network_name $redis_image redis-cli --cluster create $cluster_hosts --cluster-replicas 1;