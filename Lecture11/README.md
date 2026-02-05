##  Docker compose
1. Run docker-compose -f Lecture11/multi-container-app/docker-compose.yaml up -d![localhostNginx.png](images/localhostNginx.png)
2. Container status ![ContainersStatus.png](images/ContainersStatus.png)
3. Check app networks ![DockerNetwork.png](images/DockerNetwork.png)
4. Check app volumes ![DockerVolumes.png](images/DockerVolumes.png)
5. Access to db container![ConnectToPostgres.png](images/ConnectToPostgres.png)
6. Scale local_nginx container![NginxScale.png](images/NginxScale.png)
7. For scale nginx I need to comment port mapping in docker-compose.yaml file because of port conflict![PortConflict.png](images/PortConflict.png)