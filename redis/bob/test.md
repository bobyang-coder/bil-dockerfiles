```
docker run --name redis-node1 --network host -v  /Users/bob/Documents/workspace/github/bil-dockerfiles/redis/bob/redis_cluster.conf:/data/redis_cluster.conf -d redis redis-server  /data/redis_cluster.conf --appendonly yes
docker run --name redis-node2 --network host -v  /Users/bob/Documents/workspace/github/bil-dockerfiles/redis/bob/redis_cluster.conf:/data/redis_cluster.conf -d redis redis-server  /data/redis_cluster.conf --appendonly yes
docker run --name redis-node3 --network host -v  /Users/bob/Documents/workspace/github/bil-dockerfiles/redis/bob/redis_cluster.conf:/data/redis_cluster.conf -d redis redis-server  /data/redis_cluster.conf --appendonly yes
docker run --name redis-node4 --network host -v  /Users/bob/Documents/workspace/github/bil-dockerfiles/redis/bob/redis_cluster.conf:/data/redis_cluster.conf -d redis redis-server  /data/redis_cluster.conf --appendonly yes
docker run --name redis-node5 --network host -v  /Users/bob/Documents/workspace/github/bil-dockerfiles/redis/bob/redis_cluster.conf:/data/redis_cluster.conf -d redis redis-server  /data/redis_cluster.conf --appendonly yes
docker run --name redis-node6 --network host -v  /Users/bob/Documents/workspace/github/bil-dockerfiles/redis/bob/redis_cluster.conf:/data/redis_cluster.conf -d redis redis-server  /data/redis_cluster.conf --appendonly yes


docker run -it --network host --rm redis redis-cli --cluster create  --cluster-replicas 1  172.22.0.2:6379 172.22.0.3:6379 172.22.0.4:6379  172.22.0.5:6379 172.22.0.6:6379 172.22.0.7:6379


docker run --name some-redis -d  --user root redis redis-server  --appendonly yes
docker inspect -f '{{(index .NetworkSettings.Networks "bob_net-redis-cluster").IPAddress}}' redis-node1
docker inspect -f '{{(index .NetworkSettings.Networks "bob_net-redis-cluster").IPAddress}}' redis-node2
docker inspect -f '{{(index .NetworkSettings.Networks "bob_net-redis-cluster").IPAddress}}' redis-node3
docker inspect -f '{{(index .NetworkSettings.Networks "bob_net-redis-cluster").IPAddress}}' redis-node4
docker inspect -f '{{(index .NetworkSettings.Networks "bob_net-redis-cluster").IPAddress}}' redis-node5
docker inspect -f '{{(index .NetworkSettings.Networks "bob_net-redis-cluster").IPAddress}}' redis-node6 
```