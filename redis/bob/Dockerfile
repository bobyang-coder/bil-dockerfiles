FROM redis:5.0.2
LABEL Author="haibo.yang"
LABEL Email="bobyang_coder@163.com"
COPY redis_cluster.conf /data/redis_cluster.conf
CMD [ "redis-server", "/data/redis_cluster.conf" ]