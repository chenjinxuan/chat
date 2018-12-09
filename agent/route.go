package main

import (
	"chat/agent/client_handler"
	. "chat/agent/types"
	"chat/common/log"
	"chat/common/utils"
	"encoding/binary"
)

// route client protocol
func route(sess *Session, p []byte) []byte {

	defer utils.PrintPanicStack(sess, p)

	if len(p) < 6 {
		log.Error("packet length error")
		sess.Flag |= SESS_KICKED_OUT
		return nil
	}

	// 读协议号
	b := int16(binary.BigEndian.Uint16(p[0:2]))

	// 根据协议号断做服务划分
	// 协议号的划分采用分割协议区间,可以自定义多个区间，用于转发到不同的后端服务
	var ret []byte
	if b > 3000 && b < 4000 {
		if err := forward(sess, p); err != nil {
			log.Errorf("service id:%v execute failed, error:%v", b, err)
			sess.Flag |= SESS_KICKED_OUT
			return nil
		}
	} else {
		if h := client_handler.Handlers[b]; h != nil {
			ret = h(sess, p)
		} else {
			log.Errorf("service id:%v not bind", b)
			sess.Flag |= SESS_KICKED_OUT
			return nil
		}
	}

	return ret
}
