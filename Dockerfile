FROM rust:alpine AS build

ARG CAIRO_VERSION

RUN apk add --update alpine-sdk

WORKDIR /output

WORKDIR /src
RUN git clone --recursive -b v$CAIRO_VERSION https://github.com/starkware-libs/cairo

WORKDIR /src/cairo
RUN cargo install --locked --root /output --path ./crates/bin/cairo-run
RUN cargo install --locked --root /output --path ./crates/bin/cairo-test
RUN cargo install --locked --root /output --path ./crates/bin/cairo-format
RUN cargo install --locked --root /output --path ./crates/bin/cairo-compile
RUN cargo install --locked --root /output --path ./crates/bin/sierra-compile
RUN cargo install --locked --root /output --path ./crates/bin/generate-syntax
RUN cargo install --locked --root /output --path ./crates/bin/starknet-compile
RUN cargo install --locked --root /output --path ./crates/bin/cairo-language-server
RUN cargo install --locked --root /output --path ./crates/bin/starknet-sierra-compile
RUN cargo install --locked --root /output --path ./crates/bin/starknet-sierra-extract-code

FROM alpine:latest

LABEL org.opencontainers.image.source=https://github.com/xJonathanLEI/docker-cairo

COPY --from=build /output/bin/* /usr/bin/
COPY --from=build /src/cairo/corelib /corelib

ENTRYPOINT [ "sh" ]
