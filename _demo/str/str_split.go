package main

import (
	"fmt"
	"strings"
)

func main() {
	// str := "https://www.obencn.com/,https://www.obencn.com/"
	str := "https://www.obencn.com/"
	strSplit(str)
}

func strSplit(str string) []string {
	arr := strings.Split(str, ",")
	fmt.Printf("arr=%+v", arr)
	return arr
}

/*
arr=[https://www.obencn.com/ https://www.obencn.com/]
Process finished with exit code 0
*/

/*
arr=[https://www.obencn.com/]
Process finished with exit code 0
*/
