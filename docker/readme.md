# Docker - Build and Usage 

* Docker command below are to build and use this specific repo and not generally valid for any Docker project
* Install **Docker Desktop** from https://docs.docker.com/   
* Go to root-dir of this repo (relative paths used durin build)

## 1. Build image 
`-t` stands for tag  

`-f` location of Dockerfile  

```
docker build --no-cache -t didactic-stats-app:v0.2.1 -f docker/v2/Dockerfile .
docker build            -t didactic-stats-app:v0.2.2 -f docker/v2/Dockerfile .
```

## 2. Usage 

### 2.1 Creates container from image and start
`-d`      detached: Docker runs it independently of terminal  
`-p`      HOST_PORT:CONTAINER_PORT  
`--name` 	Assign  name to  container  

```
docker create -p  3838:3838 --name stats-cont-v0-2-1 didactic-stats-app:v0.2.1
docker start stats-cont-v0-2-1

# create and start
docker run -d -p 50111:3838 --name stats-cont-v0-2-2 didactic-stats-app:v0.2.2
```

### 2.2 Local check/usage in browser 
http://localhost:3838  
http://localhost:50111  

### 2.3 Stop container
```
docker stop stats-cont-v0-2-1
docker stop stats-cont-v0-2-2
```

### 2.4 Get info
```
docker images
docker ps
docker ps -a
```

## 3. Clean-up

### 3.1 Remove container
`-f`  force
```
docker rm -f stats-cont-v0-2-1
docker rm -f stats-cont-v0-2-2
```

### 3.2 Erase image
```
docker rmi didactic-stats-app:v0.2.1
docker rmi didactic-stats-app:v0.2.2
```

