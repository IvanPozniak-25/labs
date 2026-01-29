##  StatefulSet for Redis cluster
1. Create Redis cluster
2. Create StatefulSet for Redis
3. Apply manifests kubectl apply -f Lecture13/redis-service-manifest.yaml -f Lecture13/redis-stateful-set-manifest.yaml
4. Verify Redis Service ![RedisService.png](images/RedisService.png)
5. Verify Redis StatefulSet ![RedisStatefulSet.png](images/RedisStatefulSet.png)
6. Verify redis pods ![RedisPods.png](images/RedisPods.png)
7. Verify replicas info kubectl exec -it redis-stateful-set-0 -- redis-cli INFO replication && kubectl exec -it redis-stateful-set-1 -- redis-cli INFO replication ![RedisReplicasInfo.png](images/RedisReplicasInfo.png)
8. Verify set key value in redis kubectl exec -it redis-stateful-set-0 -- redis-cli SET test_lab hello && kubectl exec -it redis-stateful-set-0 -- redis-cli GET test_lab ![RedisSetGetKeyValue.png](images/RedisSetGetKeyValue.png)


##  Falco DaemonSet for log collection
1. Create Falco DaemonSet yaml for log collection
2. Apply manifests kubectl apply -f Lecture13/falco-daemonset.yaml
3. Verify Falco DaemonSet ![FalcoDaemonSet.png](images/FalcoDaemonSet.png)
4. Verify Falco pods ![FalcoPods.png](images/FalcoPods.png)
5. Verify falco logs kubectl logs -l app=falco-lab -n kube-system ![FalcoLogs.png](images/FalcoLogs.png)