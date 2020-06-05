package main

import (
	"fmt"
	"strconv"
)

func main() {
	fen2yuan(10001)
}

func fen2yuan(fen int) string {
	fenStr := strconv.Itoa(fen)
	firstStr := fenStr[:len(fenStr)-2]
	lastStr := fenStr[len(fenStr)-2:]
	yuan := fmt.Sprintf("%s.%s", firstStr, lastStr)
	fmt.Printf("fen2yuan yuan=%s", yuan)
	return yuan
}
