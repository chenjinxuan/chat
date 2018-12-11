package main

import (
	"net"
	"fmt"
	"os"
)

var ch  = make(chan int)

//定义名称
var nickName string

func reader(conn *net.TCPConn) {
	buff := make([]byte,128)
	for {
		_,err := conn.Read(buff)
		if err != nil {
			ch <- 1
			break
		}

		fmt.Println(string(buff[:]))
	}
}

func main()  {
	//发送tcp请求到9999端口
	tcpAddr, _ := net.ResolveTCPAddr("tcp","127.0.0.1:9999")
	conn, err := net.DialTCP("tcp",nil,tcpAddr)

	if err != nil {
		fmt.Println("start error")
		os.Exit(0)
	}

	defer conn.Close()

	//这边接收conn传来的消息
	go reader(conn)

	fmt.Println("请输入昵称:")
	fmt.Scanln(&nickName)
	fmt.Println("你的名称为:",nickName)

	for {
		var msg string
		fmt.Scanln(&msg)
		b := []byte("<"+nickName+">"+"说:"+msg)
		conn.Write(b)

		select {
		case <-ch:
			fmt.Println("error")
			os.Exit(1)
		default:
			//让select 不阻塞
		}
	}

}