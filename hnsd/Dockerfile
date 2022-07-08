FROM alpine:latest AS base
WORKDIR /opt

RUN apk add --no-cache \
  bash \
  git

RUN git clone https://github.com/handshake-org/hnsd.git 

# Install build dependencies and compile.
FROM base AS build

RUN apk add --no-cache \
  build-base \
  automake \
  autoconf \
  libtool \
  unbound-dev

WORKDIR /opt/hnsd

RUN ./autogen.sh
RUN ./configure
RUN make


# copy all to resulting image
FROM base
RUN apk add --no-cache unbound-libs
ENV PATH="${PATH}:/opt/hnsd/bin"
COPY --from=build /opt/hnsd/hnsd /opt/hnsd/hnsd
COPY entrypoint.sh /
COPY resolv.conf /etc/resolv.conf

EXPOSE 53/udp 53/tcp

ENTRYPOINT ["/entrypoint.sh"]
