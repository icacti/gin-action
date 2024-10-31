FROM registry.cn-hangzhou.aliyuncs.com/cacticloud/golang:1.22 AS build

ADD . /gin-api

WORKDIR /gin-api

ENV CGO_ENABLED 0
ENV GOOS linux
ENV GOARCH amd64
ENV GOPROXY https://goproxy.cn,direct
ENV GO111MODULE on 

RUN go mod tidy
RUN go build -o gin-api-server

FROM registry.cn-hangzhou.aliyuncs.com/cacticloud/ubuntu:22.04_stable

WORKDIR /data/gin-api

COPY --from=build /gin-api/gin-api-server /data/gin-api

RUN apt-get update \
    && apt-get install -y ca-certificates \
    && update-ca-certificates

RUN chmod +x /data/gin-api/gin-api-server

ENTRYPOINT ["/data/gin-api/gin-api-server"]
