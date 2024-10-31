FROM golang:1.21.13 AS build

ADD . /gin-api

WORKDIR /gin-api

RUN go mod tidy
RUN go build -o gin-api-server

FROM ubuntu:22.04

WORKDIR /data/gin-api

COPY --from=build /gin-api/gin-api-server /data/gin-api

RUN apt-get update \
    && apt-get install -y ca-certificates \
    && update-ca-certificates

RUN chmod +x /data/gin-api/gin-api-server

ENTRYPOINT ["/data/gin-api/gin-api-server"]