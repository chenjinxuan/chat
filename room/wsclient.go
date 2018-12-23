package main

import (
	"flag"
	"fmt"
	"net/url"
	"github.com/gorilla/websocket"
	"bufio"
	"os"
)

var addr = flag.String("addr", "localhost:12345", "http service address")

func main() {
	u := url.URL{Scheme: "ws", Host: *addr, Path: "/ws"}
	var dialer *websocket.Dialer

	conn, _, err := dialer.Dial(u.String(), nil)
	if err != nil {
		fmt.Println(err)
		return
	}

	go timeWriter(conn)

	for {
		_, message, err := conn.ReadMessage()
		if err != nil {
			fmt.Println("read:", err)
			return
		}

		fmt.Printf("received: %s\n", message)
	}
}

func timeWriter(conn *websocket.Conn) {
	reader := bufio.NewReader(os.Stdin)
	for {
		//读取键入的内容
		str,_,_ := reader.ReadLine()


		conn.WriteMessage(websocket.TextMessage, str)
	}
}
