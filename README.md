# ft_server
![100](https://i.imgur.com/J4tLfDt.png)
### **Docker command memo:**
Build une image:
 ```sh
 $ sudo docker build -t ft_server .
 ```
 liste toutes les images:
 ```sh
 $ sudo docker images
 ```
Supprimer une image:
```sh
$ sudo docker rmi image_id
```
 Run un container:
 ```sh
 $ sudo docker run --env AUTOINDEX=on --name=ft_server -it -p 80:80 -p 443:443 ft_server
 ```
   Liste tout les containers:
 ```sh
 $ sudo docker ps -a
 ```
 Start un container:
 ```sh
 $ sudo docker start container_id
 ```
 Stop un container:
 ```sh
 $ sudo docker stop container_id
 ```
 Kill un container:
 ```sh
 $ sudo docker kill container_id
 ```
 Supprimer un container:
 ```sh
 $ sudo docker container rm container_id
 ```
  Supprimer le dernier container:
 ```sh
 $ sudo docker container rm $(docker ps –lq)
 ```
 Supprimer tous les containers:
 ```sh
 $ sudo docker container rm $(docker ps –aq)
 ```
 Console bash:
 ```sh
 sudo docker exec -it ft_server bash
 ```
 https://phoenixnap.com/kb/how-to-list-start-stop-docker-containers

### **liens d'acces:**

 `https://localhost/wordpress/wp-config.php`
 `https://localhost/phpmyadmin/`
