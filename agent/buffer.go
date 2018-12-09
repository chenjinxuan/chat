package main

import (
	"chat/common/log"
	"github.com/gorilla/websocket"

	"chat/agent/misc/packet"
	. "chat/agent/types"
	"chat/common/utils"
)

// PIPELINE #3: buffer
// controls the packet sending for the client
type Buffer struct {
	ctrl    chan struct{}   // receive exit signal
	pending chan []byte     // pending packets
	conn    *websocket.Conn // connection
	cache   []byte          // for combined syscall write
}

// packet sending procedure
func (buf *Buffer) send(sess *Session, data []byte) {
	// in case of empty packet
	if data == nil {
		return
	}

	// queue the data for sending
	select {
	case buf.pending <- data:
	default: // packet will be dropped if txqueuelen exceeds
		log.Info("user pending full")
	}
	return
}

// packet sending goroutine
func (buf *Buffer) start() {
	defer utils.PrintPanicStack()
	for {
		select {
		case data := <-buf.pending:
			buf.raw_send(data)
		case <-buf.ctrl: // receive session end signal
			return
		}
	}
}

// raw packet encapsulation and put it online
func (buf *Buffer) raw_send(data []byte) bool {
	// combine output to reduce syscall.write
	sz := len(data)
	copy(buf.cache, data)
	// write data
	err := buf.conn.WriteMessage(websocket.BinaryMessage, buf.cache[:sz])
	if err != nil {
		log.Warnf("Error send reply data, reason: %v", err)
		return false
	}

	return true
}

// create a associated write buffer for a session
func new_buffer(conn *websocket.Conn, ctrl chan struct{}, txqueuelen int) *Buffer {
	buf := Buffer{conn: conn}
	buf.pending = make(chan []byte, txqueuelen)
	buf.ctrl = ctrl
	buf.cache = make([]byte, packet.PACKET_LIMIT+2)
	return &buf
}
