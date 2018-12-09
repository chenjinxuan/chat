package types

import (
	pb "chat/common/pb"
	"net"
	"time"
)

const (
	SESS_KICKED_OUT = 0x4 // 踢掉
	SESS_AUTHORIZED = 0x8 // 已授权访问
)

type Session struct {
	IP     net.IP
	MQ     chan pb.Chat_Frame          // 返回给客户端的异步消息
	UserId int64                       // 玩家ID
	Token  string                      //token
	GSID   string                      // 聊天服id
	Stream pb.ChatService_StreamClient // chat服务数据流
	Die    chan struct{}               // 会话关闭信号

	// 会话标记
	Flag int32

	// 时间相关
	ConnectTime    time.Time // TCP链接建立时间
	PacketTime     time.Time // 当前包的到达时间
	LastPacketTime time.Time // 前一个包到达时间

	PacketCount     uint32 // 对收到的包进行计数，避免恶意发包
	PacketCount1Min int    // 每分钟的包统计，用于RPM判断
}
