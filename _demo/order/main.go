package main

import (
	"fmt"
	"time"
)

func main() {
	fmt.Println(time.Now().UnixNano())
	fmt.Println(time.Now().Unix())
}
