# docker-maxlayers

I'm using this docker image to test docker pull performance. I've maximized the number of layers and each layer is bloated with 10MB of unique junk.

## BUILD

First, generate some bloat:
```
./bloat_generator.sh
```

This will generate 124 bloat files each 10MB in size. The docker build will copy each file as an individual layer. I was able to build 127 layers with the *scratch* base layer and bloat layers:

```
docker build -t maxlayers .
```

