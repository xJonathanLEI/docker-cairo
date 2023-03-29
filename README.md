# docker-cairo

Multi-arch Docker images with Cairo binaries.

## Docker Hub

Docker images are built by GitHub Actions and made available on [Docker Hub](https://hub.docker.com/r/starknet/cairo).

## Usage

All Cairo binaries are available in `PATH` of the images. For example, to format the `erc20.cairo` file using `cairo-format` from Cairo `v1.0.0-alpha.6`:

```console
$ docker run -it --rm -v $(pwd):/work \
    --entrypoint cairo-format \
    starknet/cairo:1.0.0-alpha.6 \
    /work/erc20.cairo
```
