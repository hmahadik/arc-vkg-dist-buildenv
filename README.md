### Running docker image
```bash
docker pull hmahadik/arc-vkg-dist-buildenv

# note: set the dist_url correctly
docker run --env "dist_url=http://../Arcturus-Viking-dist-P242.316.1940.tar.bz2" \
	--env "host_uid=$(id -u)" --env "host_gid=$(id -g)" \
	-v $(PWD):/home/build/ --name arc-vkg-dist-buildenv hmahadik/arc-vkg-dist-buildenv
```
