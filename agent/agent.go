package main

import (
	. "chat/agent/types"
	pb "chat/common/pb"
	"chat/common/utils"
	"time"
)

func agent(sess *Session, in chan []byte, out *Buffer) {
	defer wg.Done()
	defer utils.PrintPanicStack()

	// init session
	sess.MQ = make(chan pb.Chat_Frame, 512)
	sess.ConnectTime = time.Now()
	sess.LastPacketTime = time.Now()
	// cleanup work
	defer func() {
		close(sess.Die)
		if sess.Stream != nil {
			sess.Stream.CloseSend()
		}
	}()

	//  the main message loop
	// handles 4 types of message:
	//  1. from client
	//  2. from chat service
	//  3. timer
	//  4. server shutdown signal
	for {
		select {
		case msg, ok := <-in: // packet from network
			if !ok {
				return
			}

			sess.PacketCount++
			sess.PacketCount1Min++
			sess.PacketTime = time.Now()

			if result := route(sess, msg); result != nil {
				out.send(sess, result)
			}
			sess.LastPacketTime = sess.PacketTime
		case frame := <-sess.MQ: // packets from game
			switch frame.Type {
			case pb.Chat_Message:
				out.send(sess, frame.Message)
			case pb.Chat_Kick:
				sess.Flag |= SESS_KICKED_OUT
			}
		case <-die: // server is shuting down...
			sess.Flag |= SESS_KICKED_OUT
		}

		if sess.Flag&SESS_KICKED_OUT != 0 {
			return
		}
	}
}
