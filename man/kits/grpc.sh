#!/usr/bin/env bash

### grpc
# hellostreamingworld -> helloworld -> route_guide
CMAKE_CURRENT_BINARY_DIR=/ddd/middle/hello-protobuf-grpc/cmake-build-debug/grpc-hellostreamingworld
hw_proto_path=/ddd/middle/hello-protobuf-grpc/grpc-helloworld/protos
_GRPC_CPP_PLUGIN_EXECUTABLE=/usr/local/bin/grpc_cpp_plugin
hw_proto=/ddd/middle/hello-protobuf-grpc/grpc-helloworld/protos/hellostreamingworld.proto

protoc --grpc_out "${CMAKE_CURRENT_BINARY_DIR}" --cpp_out "${CMAKE_CURRENT_BINARY_DIR}" -I "${hw_proto_path}" --plugin=protoc-gen-grpc="${_GRPC_CPP_PLUGIN_EXECUTABLE}" "${hw_proto}"

Official GitHub mirror: github.com/justinfrankel/licecap
