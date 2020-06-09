package main

import (
	"fmt"
	"strconv"
)

func main() {
	fmt.Println(fen2yuan(1))
	fmt.Println(fen2yuan(10))
	fmt.Println(fen2yuan(100))

	fmt.Println(fen2yuan(11))
	fmt.Println(fen2yuan(101))
	fmt.Println(fen2yuan(1001))
}

func fen2yuan(fen int) string {
	fenStr := strconv.Itoa(fen)
	if len(fenStr) == 1 {
		return fmt.Sprintf("0.0%s", fenStr)
	} else if len(fenStr) == 2 {
		return fmt.Sprintf("0.%s", fenStr)
	}
	firstStr := fenStr[:len(fenStr)-2]
	lastStr := fenStr[len(fenStr)-2:]
	yuan := fmt.Sprintf("%s.%s", firstStr, lastStr)
	return yuan
}
