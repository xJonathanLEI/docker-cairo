FROM rust:alpine AS build

ARG CAIRO_VERSION

RUN apk add --update alpine-sdk

WORKDIR /output

WORKDIR /src
RUN git clone --recursive -b v$CAIRO_VERSION https://github.com/starkware-libs/cairo

WORKDIR /src/cairo
RUN cargo install --locked --root /output --path ./crates/cairo-lang-compiler
RUN cargo install --locked --root /output --path ./crates/cairo-lang-formatter
RUN cargo install --locked --root /output --path ./crates/cairo-lang-language-server
RUN cargo install --locked --root /output --path ./crates/cairo-lang-runner
RUN cargo install --locked --root /output --path ./crates/cairo-lang-sierra-to-casm
RUN cargo install --locked --root /output --path ./crates/cairo-lang-starknet
RUN cargo install --locked --root /output --path ./crates/cairo-lang-syntax-codegen
RUN cargo install --locked --root /output --path ./crates/cairo-lang-test-runner

FROM alpine:latest

LABEL org.opencontainers.image.source=https://github.com/xJonathanLEI/docker-cairo

COPY --from=build /output/bin/* /usr/bin/
COPY --from=build /src/cairo/corelib /corelib

ENTRYPOINT [ "sh" ]
