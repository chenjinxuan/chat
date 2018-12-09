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

	"get_friend_list_req": 3001, //获取好友列表
	"get_friend_list_ack": 3002, //获取好友列表回复
	"get_group_lis_req":   3003, //获取组列表
	"get_group_lis_ack":   3004, //获取组列表
	"get_group_info_req":  3005, //获取组成员信息
	"get_group_info_ack":  3006, //获取组成员信息
	"single_chat_req":     3007, //个人聊天
	"single_chat_ack":     3008, //个人聊天
	"group_chat_req":      3009, //群聊
	"group_chat_ack":      3010, //群聊
}

var RCode = map[int16]string{
	0:  "heart_beat_req", // 心跳包..
	1:  "heart_beat_ack", // 心跳包回复
	10: "user_login_req", // 登陆
	11: "user_login_ack", // 登陆成功
	40: "kicked_out_ack", // 踢出通知

	1001: "centre_ping_req", //  ping
	1002: "centre_ping_ack", //  pong

	3001: "get_friend_list_req",
	3002: "get_friend_list_ack",
	3003: "get_group_lis_req",
	3004: "get_group_lis_ack",
	3005: "get_group_info_req",
	3006: "get_group_info_ack",
	3007: "single_chat_req",
	3008: "single_chat_ack",
	3009: "group_chat_req",
	3010: "group_chat_ack",
}

const (
	AUTH_FAIL    = -999
	SYSTEM_ERROR = -1000
)
