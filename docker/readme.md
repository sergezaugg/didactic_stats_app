# Docker - Build and Usage 

* Docker command below are to build and use this specific repo and not generally valid for any Docker project
* Install **Docker Desktop** from <a href="https://docs.docker.com/" target="_blank">Docker documentation</a>.
* Go to root-dir of this repo (relative paths used durin build)

## Build image 
`-t` stands for tag  

`-f` location of Dockerfile  

```
docker build --no-cache -t didactic-stats-app:v0.2.1 -f docker/Dockerfile .
docker build            -t didactic-stats-app:v0.2.2 -f docker/Dockerfile .
```

## Usage 

### Creates container from image and start
`-d`      detached: Docker runs it independently of terminal  
`-p`      HOST_PORT:CONTAINER_PORT  
`--name` 	Assign  name to  container  

```
docker create -p  3838:3838 --name stats-cont-v0-2-1 didactic-stats-app:v0.2.1
docker start stats-cont-v0-2-1

# create and start
docker run -d -p 50111:3838 --name stats-cont-v0-2-2 didactic-stats-app:v0.2.2
```

### Local check/usage in browser 
<a href="http://localhost:3838" target="_blank">http://localhost:3838</a>  
<a href="http://localhost:50111" target="_blank">http://localhost:50111</a>

### Stop container
```
docker stop stats-cont-v0-2-1
docker stop stats-cont-v0-2-2
```

### Get info
```
docker images
docker ps
docker ps -a
```

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

