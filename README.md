### Building docker image
```bash
# note: you'll need to set the dist_url arg below
docker build --build-arg dist_url="http://" -t vikmx-buildenv .
```

### Running docker image
```bash
docker run -it vikmx-buildenv bash
```
