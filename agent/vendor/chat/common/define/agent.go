package define

// 网关协议号定义
var Code = map[string]int16{
	"heart_beat_req": 0,  // 心跳包..
	"heart_beat_ack": 1,  // 心跳包回复
	"user_login_req": 10, // 登陆
	"user_login_ack": 11, // 登陆成功
	"kicked_out_ack": 40, // 踢出通知

	"centre_ping_req": 1001, //  ping
	"centre_ping_ack": 1002, //  pong

	"get_friend_list": 3001, //获取好友列表
	"get_group_lis":   3002, //获取组列表
	"get_group_info":  3003, //获取组成员信息
	"single_chat":     3004, //个人聊天
	"group_chat":      3005, //群聊

}

var RCode = map[int16]string{
	0:  "heart_beat_req", // 心跳包..
	1:  "heart_beat_ack", // 心跳包回复
	10: "user_login_req", // 登陆
	11: "user_login_ack", // 登陆成功
	40: "kicked_out_ack", // 踢出通知

	1001: "centre_ping_req", //  ping
	1002: "centre_ping_ack", //  pong
	3001: "get_friend_list",
	3002: "get_group_lis",
	3003: "get_group_info",
	3004: "single_chat",
	3005: "group_chat",
}

const (
	AUTH_FAIL    = -999
	SYSTEM_ERROR = -1000
)
