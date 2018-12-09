package main

import (
	"errors"

	. "chat/agent/types"
	"chat/common/log"
	pb "chat/common/pb"
)

var (
	ERROR_STREAM_NOT_OPEN = errors.New("stream not opened yet")
)

// forward messages to game server
func forward(sess *Session, p []byte) error {
	frame := &pb.Chat_Frame{
		Type:    pb.Chat_Message,
		Message: p,
	}

	// check stream
	if sess.Stream == nil {
		return ERROR_STREAM_NOT_OPEN
	}

	// forward the frame to game
	if err := sess.Stream.Send(frame); err != nil {
		log.Error(err)
		return err
	}
	return nil
}
