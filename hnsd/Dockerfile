FROM alpine:latest AS base
WORKDIR /opt
RUN apk add --no-cache \
  build-base \
  bash \
  git \
  automake \
  autoconf \
  libtool \
  unbound-dev

RUN git clone https://github.com/handshake-org/hnsd.git 

# Install build dependencies and compile.
FROM base AS build

WORKDIR /opt/hnsd

RUN ./autogen.sh
RUN ./configure
RUN make


# copy all to resulting image
FROM base
RUN apk add --no-cache unbound-libs
ENV PATH="${PATH}:/opt/hnsd/bin"
COPY --from=build /opt/hnsd /opt/hnsd
COPY entrypoint.sh /
COPY resolv.conf /etc/resolv.conf

EXPOSE 53/udp 53/tcp

ENTRYPOINT ["/entrypoint.sh"]
