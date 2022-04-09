
- https://go.dev/blog/cgo
- https://pkg.go.dev/cmd/cgo#hdr-Go_references_to_C


/usr/local/go/src/cmd/cgo/out.go

- https://github.com/golang/go/blob/master/src/cmd/cgo/doc.go
- https://github.com/golang/go/blob/master/misc/cgo/test/test.go

- https://stackoverflow.com/questions/26190410/freeing-c-variables-in-golang
- http://golang.org/cmd/cgo/
- https://code.google.com/p/go-wiki/wiki/cgo
- http://blog.golang.org/c-go-cgo


### cgo
```go
package main

/*
#include "lib/lib.h"
#include <stdlib.h>       // for free()
#include <string.h>       // for free()
#cgo LDFLAGS: -L. -lcgo1
// simple wrapper, see below
void call_f5_with_f1(void) {
	f5(f1);
}
*/
import "C"

import (
	"fmt"
	"unsafe"
)
```

### compile and exec
```shell
$(CC) -g -fPIC -c -o lib/lib.o lib/lib.c
$(CC) -g -fPIC -shared -o libcgo1.so lib/lib.o
gofmt -e -s -w .
# go vet .
LD_LIBRARY_PATH=. go run main.go
```


### C.free
```c
cs := C.CString("a string")
C.free(unsafe.Pointer(cs))
```

### C.size_t
```c
	v1 := C.short(0x7001)
	fmt.Printf("%v\n", v1)
	v2 := C.ushort(0xF001)
	fmt.Printf("%v\n", v2)
	v3 := C.int(0x70017001)
	fmt.Printf("%v\n", v3)
	v4:= C.uint(0xF001F001)
	fmt.Printf("%v\n", v4)
	v5 := C.longlong(0x7001700170017001)
	fmt.Printf("%v\n", v5)
	v6:= C.ulonglong(0xF001F0010001F001)
	fmt.Printf("%v\n", v6)
```


### string
```go
func C.CString(string) *C.char
func C.GoString(*C.char) string
func C.GoStringN(*C.char, C.int) string
func C.GoBytes(unsafe.Pointer, C.int) []byte
```

### C.GoBytes() 是 C.GoStringN() 的另一个版本，不返回 string 而是返回 []byte
### C.GoStringN() 把整个 N 长度的 C buffer 复制为一个 Go 字符串
```c
C.GoStringN(&field, 64)
```

### sizeof struct
```c
cs := C.CString("a string")
C.free(unsafe.Pointer(cs))
```
