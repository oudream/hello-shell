package main

// #cgo CFLAGS: -g -Wall
// #include <stdio.h>
// void hello() {
//     printf("Hello, Cgo!\n");
// }
import "C"

import "fmt"

func main() {
    fmt.Println("Hello, Go and CGO!")
    C.hello()
}
