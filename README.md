# Static Site Server Project
This is a project from roadmap.sh, which can be found here:

https://roadmap.sh/projects/static-site-server

## Requirements
Setup a remote linux server:
- configure it to allow SSH
- install nginx to serve the static site
Create a simple webpage
- use basic HTML, CSS and image files
Use rsync to update the remote server with the simple webpage components
- create a deploy.sh to deploy the static site to the server
Set up nginx to serve the static site from the remote linux servers IP address

### Requirement modifications
- Use a local Docker container to be the remote linux server

## Clone this repo
This repo contains the Dockerfile needed to create the remote linux server with SSH capabilities.
```bash
git clone git@github.com:jjk66/static-site-server.git
cd static-site-server.git
```

## Create test SSH key pair for inclusion
To SSH we will create some test keys for use in the docker container posing as the remote linux server. The new public key needs to be in the root directory of the cloned repo since the Dockerfile will copy the public key into the container.
```bash
ssh-keygen -t ed25519 -f ~/.ssh/test_key_1 -N ""
cp -p ~/.ssh/test_key_1.pub <cloned repo root>/.
```

## Setup a Remote Linux Server
This project will use a local Docker container in place of using simple droplet DigitalOcean container.

### Assumptions: 
- Local Docker daemon for building images and running containers.
- users public SSH key needed for the local linux contianer building

### Build local-droplet image
```bash
cd <cloned repo root>
docker build -t local-droplet-ssh .
```
### Build the local-droplet-ssh container
The container will port forward port 22 from container to local port 2222
```bash
docker run -d --name my-remote-server -p 2222:22 local-droplet-ssh
```


