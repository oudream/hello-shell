# Start from the latest golang base image
FROM golang:latest as go-builder
# Add Maintainer Info
LABEL maintainer="oudream <oudream@126.com>"
# Set the Current Working Directory inside the container
WORKDIR /app
# Copy go mod and sum files
COPY go.mod go.sum ./
# Download all dependencies. Dependencies will be cached if the go.mod and go.sum files are not changed
#RUN go env -w GOPRIVATE=.gitlab.com,.gitee.com && go mod download
# Copy the source from the current directory to the Working Directory inside the container
COPY ./cmd ./cmd
COPY ./vendor ./vendor
# Install gcc-aarch64
RUN apt-get update && apt-get install -y gcc-aarch64-linux-gnu
# Build the Go app
RUN CGO_ENABLED=1 CC=aarch64-linux-gnu-gcc GOOS=linux GOARCH=arm64 go build -o output/tk5web ./cmd
# Start from the latest alpine base image
FROM arm64v8/alpine
# Set the Current Working Directory inside the container
WORKDIR /app
# Copy execute file from go-builder
COPY --from=go-builder /app/output/tk5web /app/tk5web
COPY deploy/assets /app/assets
COPY deploy/conf /app/conf
# lib /lib64/ld-linux-x86-64.so.2
RUN mkdir /lib64 \
    && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2 \
    && apk add -U tzdata \
    && cp "/usr/share/zoneinfo/Asia/Shanghai" "/etc/localtime" \
    && echo "Asia/Shanghai" > "/etc/timezone" \
    && chmod 755 /app/tk5web
# Set docker image command
CMD [ "/app/tk5web", "-d", "/app" ]