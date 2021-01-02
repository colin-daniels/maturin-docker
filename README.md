# maturin-docker
Docker image with maturin, manylinux2010, and pinned rust version.
```sh
docker build \
    --build-arg MATURIN_VERSION=0.8.3 \
    --build-arg CFFI_VERSION=1.14.4 \
    --build-arg RUST_VERSION=1.48.0 \
    -t maturin .
cd ~/your/code/directory
docker run --rm -v "$PWD:/app" maturin build --manylinux 2010
```
