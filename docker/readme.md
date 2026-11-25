# Docker Build and Usage 

## Build image 
-t stands for tag  

-f --file specifies location of the Dockerfile  

```
docker build --no-cache -t didactic-stats-app -f docker/Dockerfile .

docker build -t didactic-stats-app -f docker/Dockerfile .
```


## Creates container from image and start
-d = detached: Docker runs it independently of terminal  
-p HOST_PORT:CONTAINER_PORT  
`--name` 	Assign  name to  container  

```
docker run -d -p 3838:3838 --name app01 didactic-stats-app
docker run -d -p 50111:3838 --name app02 didactic-stats-app
```

## Exposed in browser 
http://localhost:3838
http://localhost:50111

## Start / stop an existing container.
```
docker start app01
docker stop app01
```

## Remove existing container
```
docker rm -f app01
```

## get info
```
docker ps
docker ps -a
docker images
```

## Erase image 
```
docker rmi didactic-stats-app
```

