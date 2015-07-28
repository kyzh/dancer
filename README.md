## Introduction
This is a Dockerfile to build a (minimal) container image for a dancer app, with the ability to use local app or to pull code from git.  
The container will eventually use environment variables to configure your web application.   

### Git reposiory
The source files for this project can be found here: [https://github.com/ngineered/dancer](https://github.com/ngineered/dancer)

If you have any improvements please submit a pull request.
### Docker hub repository
The Docker hub build can be found here: [https://registry.hub.docker.com/u/ngineered/dancer/](https://registry.hub.docker.com/u/ngineered/dancer)


## Installation
Pull the image from the docker index rather than downloading the git repo.  
This prevents you having to build the image on every docker host.  

```
docker pull ngineered/dancer:latest
```

## Running
To simply run the container:

```
sudo docker run --name dancer -p 5000:80 -d ngineered/dancer
```
You can then browse to http://\<docker_host\>:80 or http://localhost:80 or http://127.0.0.1:80 to view the site.  

### Volumes
If you want to link to your app directory on the docker host to the container run:

```
sudo docker run --name dancer -p 5000:80 -v /your_code_directory:/var/www -d ngineered/dancer
```

### Pulling code from git
One of the nice features of this container is its ability to pull code from a git repository with a couple of environmental variables passed at run time.  

**Note:** You need to have your SSH key that you use with git to enable the deployment.  
I recommend using a special deploy key per project to minimise the risk.

To run the container and pull code simply specify the GIT_REPO URL including *git@* and then make sure you have a folder on the docker host with your id_rsa key stored in it:

```
sudo docker run -e 'GIT_REPO=git@git.ngd.io:flo/dancing-queen.git'  -v /opt/ngddeploy/:/root/.ssh -p 5000:80 -d ngineered/dancer
```

To pull a repository and specify a branch add the GIT_BRANCH environment variable:

```
sudo docker run -e 'GIT_REPO=git@git.ngd.io:flo/dancing-queen.git' -e 'GIT_BRANCH=dev' -v /opt/ngddeploy/:/root/.ssh -p 5000:80 -d ngineered/dancer
```

## Special Features

### Push code to Git
To push code changes back to git simply run:
```
sudo docker exec -t -i <CONATINER_NAME> /usr/bin/push
```
### Pull code from Git (Refresh)
In order to refresh the code in a container and pull newer code form git simply run:
```
sudo docker exec -t -i <CONTAINER_NAME> /usr/bin/pull
```
