# KR

## build

Build addon with command
```shell
docker run --rm --privileged -v ~/.docker:/root/.docker -v /var/run/docker.sock:/var/run/docker.sock   -v ~/git/kr/hassio_addons/kr:/data homeassistant/amd64-builder --all -t /data --no-cache --docker-hub jimus --addon
```
