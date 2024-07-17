FROM golang:1.19.10-alpine3.18
# golang:1.17-alpine

WORKDIR /app

COPY . .

RUN apk add --no-cache gcc musl-dev

RUN go build -o app

CMD ["./app"]
