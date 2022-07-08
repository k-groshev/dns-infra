FROM node:14-alpine AS base
WORKDIR /opt/hsd
RUN apk add --no-cache bash unbound-dev gmp-dev git
RUN git clone https://github.com/handshake-org/hsd.git /opt/hsd

# Install build dependencies and compile.
FROM base AS build
RUN apk add --no-cache g++ gcc make python3 

RUN npm install --production

# copy all to resulting image
FROM base
ENV PATH="${PATH}:/opt/hsd/bin:/opt/hsd/node_modules/.bin"
COPY --from=build /opt/hsd/node_modules /opt/hsd/node_modules/
COPY --from=build /opt/hsd/bin /opt/hsd/bin/
COPY --from=build /opt/hsd/lib /opt/hsd/lib/
COPY entrypoint.sh /

EXPOSE 53/udp 53/tcp

ENTRYPOINT ["/entrypoint.sh"]
