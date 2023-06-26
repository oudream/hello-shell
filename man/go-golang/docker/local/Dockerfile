FROM golang:1.19.10-alpine3.18

RUN apk add --no-cache build-base cmake bash

RUN go env -w GO111MODULE=on \
    && go env -w GOPROXY=https://goproxy.cn,direct
