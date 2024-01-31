package main

import (
	"fmt"
	"runtime"
)

func main() {
	fmt.Println("Hello world!")
	fmt.Printf("Running in [%s] architecture.\n", runtime.GOARCH)
}