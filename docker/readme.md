# Docker Build and Usage 

Docker command below are to build and use this specific repo and not generally valid for any Docker project

<hr style="height: 3px; background-color: #0099ee; border: none; border-radius: 2px;">

### Setup 

* Install **Docker Desktop** from https://docs.docker.com/
* Go to root-dir of this repo (relative paths used below)


<br>
<hr style="height: 3px; background-color: #0099ee; border: none; border-radius: 2px;">


### Build image 
`-t` stands for tag  

`-f` location of Dockerfile  

```
docker build --no-cache -t didactic-stats-app:v0.2.1 -f docker/Dockerfile .
docker build            -t didactic-stats-app:v0.2.2 -f docker/Dockerfile .
```

### Creates container from image and start / stop
`-d` = detached: Docker runs it independently of terminal  
`-p` HOST_PORT:CONTAINER_PORT  
`--name` 	Assign  name to  container  

```
docker create -p  3838:3838 --name stats-cont-v0-2-1 didactic-stats-app:v0.2.1
docker start stats-cont-v0-2-1

# create and start
docker run -d -p 50111:3838 --name stats-cont-v0-2-2 didactic-stats-app:v0.2.2

docker stop stats-cont-v0-2-1
docker stop stats-cont-v0-2-2
```

### Exposed in browser 
http://localhost:3838  
http://localhost:50111   


### Get info
```
docker images
docker ps
docker ps -a

```

<br>
<hr style="height: 3px; background-color: #0099ee; border: none; border-radius: 2px;">



## Clean-up

### Remove container
`-f`  force
```
docker rm -f stats-cont-v0-2-1
docker rm -f stats-cont-v0-2-2
```

### Erase image
```
docker rmi didactic-stats-app:v0.2.1
docker rmi didactic-stats-app:v0.2.2
```

