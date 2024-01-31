FROM golang:1.19.10-alpine3.18

WORKDIR /opt/dev/device_communicator

COPY ./../../../ .

RUN apk add --no-cache build-base bash cmake

RUN cd hy/setup && make

CMD ["bash"]
