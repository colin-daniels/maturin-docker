# Note that versions are pinned for reproducibility
FROM quay.io/pypa/manylinux2010_x86_64:2020-12-31-4928808

ARG MATURIN_VERSION=0.8.3
ARG CFFI_VERSION=1.14.4
ARG RUST_VERSION=1.48.0
ARG RUSTUP_SHA256=49c96f3f74be82f4752b8bffcf81961dea5e6e94ce1ccba94435f12e871c3bdb

# Add all python paths, use the maturin --interpreter flag to select or use autodiscovery.
ENV PATH=/opt/python/cp35-cp35m/bin:$PATH
ENV PATH=/opt/python/cp36-cp36m/bin:$PATH
ENV PATH=/opt/python/cp37-cp37m/bin:$PATH
ENV PATH=/opt/python/cp38-cp38/bin:$PATH
ENV PATH=/opt/python/cp39-cp39/bin:$PATH
ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH \
    RUST_VERSION=$RUST_VERSION

RUN set -eux; \
    rustArch='x86_64-unknown-linux-gnu'; \
    url="https://static.rust-lang.org/rustup/archive/1.22.1/${rustArch}/rustup-init"; \
    curl "$url" -o rustup-init; \
    echo "${RUSTUP_SHA256} *rustup-init" | sha256sum -c -; \
    chmod +x rustup-init; \
    ./rustup-init -y --no-modify-path --profile minimal --default-toolchain $RUST_VERSION --default-host ${rustArch}; \
    rm rustup-init; \
    chmod -R a+w $RUSTUP_HOME $CARGO_HOME; \
    python3 -m pip install --no-cache-dir \
        cffi==$CFFI_VERSION \
        maturin==$MATURIN_VERSION;

WORKDIR /io
ENTRYPOINT ["/bin/env", "maturin"]
