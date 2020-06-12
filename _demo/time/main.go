package main

import (
	"fmt"
	"time"
)

const (
	// 抽奖过期时间
	// LotteryExpireAtString = "2020-09-30T23:59:59+08:00"

	LotteryExpireAtString = "2020-06-12T18:13:59+08:00"
)

func main() {
	expireTime, err := time.Parse(time.RFC3339, LotteryExpireAtString)
	if err != nil {
		return
	}
	if time.Now().After(expireTime) {
		fmt.Println("抽奖结束")
	} else {
		fmt.Println("抽奖进行")
	}
}
