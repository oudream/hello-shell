#!/usr/bin/env bash

### .NET Framework 对 gRPC over HTTP/2 的支持有限。 要求和限制：Windows 11 或更高版本，Windows Server 2022 或更高版本。
- https://learn.microsoft.com/zh-cn/aspnet/core/grpc/netstandard?view=aspnetcore-8.0

### Cpp gRPC Windows PreBuilts
- https://github.com/thommyho/Cpp-gRPC-Windows-PreBuilts


### C# Grpc.Net.Client 2.60.0 对应 c++ 1.60.0
```shell
git clone --recurse-submodules -b v1.60.0 https://github.com/grpc/grpc

```

### 生成
```shell
protoc --proto_path=proto --csharp_out=output_directory --grpc_out=output_directory --plugin=protoc-gen-grpc=path_to_grpc_tools\grpc_csharp_plugin.exe your_service.proto

protoc --proto_path=输入目录 --csharp_out=输出目录 --grpc_out=输出目录 --plugin=protoc-gen-grpc=grpc_csharp_plugin的路径 输入文件.proto

protoc --proto_path=image_transfer.proto --csharp_out=输出目录 --grpc_out=输出目录 --plugin=protoc-gen-grpc=grpc_csharp_plugin的路径 输入文件.proto

protoc -I. --grpc_out=. --plugin=protoc-gen-grpc=`grpc_cpp_plugin.exe` image_transfer.proto

protoc --proto_path=. --cpp_out=. --grpc_out=. --plugin=protoc-gen-grpc="E:/gRPC/MSVC142_64/Release/bin/grpc_cpp_plugin.exe" image_processing.proto
protoc --proto_path=. --csharp_out=. --grpc_out=. --plugin=protoc-gen-grpc="E:/gRPC/MSVC142_64/Release/bin/grpc_csharp_plugin.exe" image_processing.proto


```


###
- https://github.com/protocolbuffers/protobuf
- https://github.com/grpc/grpc
- https://github.com/thommyho/Cpp-gRPC-Windows-PreBuilts


### grpc
# hellostreamingworld -> helloworld -> route_guide
CMAKE_CURRENT_BINARY_DIR=/ddd/middle/hello-protobuf-grpc/cmake-build-debug/grpc-hellostreamingworld
hw_proto_path=/ddd/middle/hello-protobuf-grpc/grpc-helloworld/protos
_GRPC_CPP_PLUGIN_EXECUTABLE=/usr/local/bin/grpc_cpp_plugin
hw_proto=/ddd/middle/hello-protobuf-grpc/grpc-helloworld/protos/hellostreamingworld.proto

protoc --grpc_out "${CMAKE_CURRENT_BINARY_DIR}" --cpp_out "${CMAKE_CURRENT_BINARY_DIR}" -I "${hw_proto_path}" --plugin=protoc-gen-grpc="${_GRPC_CPP_PLUGIN_EXECUTABLE}" "${hw_proto}"

Official GitHub mirror: github.com/justinfrankel/licecap
