FROM --platform=$BUILDPLATFORM golang:1.14 as builder

ARG TARGETARCH

WORKDIR /app
COPY main.go /app/main.go
RUN GOOS=linux GOARCH=$TARGETARCH go build -a -o output/main main.go

FROM alpine:latest
WORKDIR /root
COPY --from=builder /app/output/main .
CMD /root/main