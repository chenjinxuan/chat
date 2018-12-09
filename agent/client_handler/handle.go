package client_handler

import (
	"chat/agent/misc/packet"
	. "chat/agent/types"
	. "chat/common/define"
	"chat/common/log"
	pb "chat/common/pb"
	"chat/common/services"
	"context"
	"fmt"
	"github.com/golang/protobuf/proto"
	"google.golang.org/grpc"
	"google.golang.org/grpc/metadata"
	"io"
	"time"
)

var Handlers map[int16]func(*Session, []byte) []byte

func init() {
	Handlers = map[int16]func(*Session, []byte) []byte{
		0:  P_heart_beat_req,
		10: P_user_login_req,
	}
}

// 心跳包 直接把数据包发回去
func P_heart_beat_req(sess *Session, data []byte) []byte {
	req := &pb.AutoId{}
	err := proto.Unmarshal(data[2:], req)
	if err != nil {
		log.Error("P_heart_beat_req Unmarshal ERROR", err)
	}
	return packet.Pack(Code["heart_beat_ack"], req)
}

// 登陆过程
func P_user_login_req(sess *Session, data []byte) []byte {
	req := &pb.UserLoginReq{}
	err := proto.Unmarshal(data[2:], req)
	if err != nil {
		log.Error("P_user_login_req Unmarshal ERROR ", err)
	}

	log.Debug("P_user_login_req: ", req)

	// 登陆鉴权
	authConn, authServiceId := services.GetService2(SRV_NAME_USERCENTER)
	if authConn == nil {
		log.Error("cannot get auth service:", authServiceId)
		return nil
	}
	authCli := pb.NewUserCenterServiceClient(authConn)
	authRes, err := authCli.CheckAuth(context.Background(), &pb.AuthArgs{UserId: req.UserId, Token: req.Token})
	if err != nil {
		log.Error("authCli.Auth: ", err)
		return packet.Pack(Code["user_login_ack"], &pb.UserLoginAck{BaseAck: &pb.BaseAck{Ret: SYSTEM_ERROR, Msg: "system error."}})
	}
	if authRes.Ret != 1 {
		return packet.Pack(Code["user_login_ack"], &pb.UserLoginAck{BaseAck: &pb.BaseAck{Ret: AuthFailedStatus, Msg: "Auth fail."}})
	}

	sess.UserId = req.UserId
	sess.Token = req.Token

	// 选择聊天服务器
	var serviceId string
	var conn *grpc.ClientConn
	if req.ConnectTo != "" { // 客户端指定连接的服务
		serviceId = req.ConnectTo
		conn = services.GetServiceWithId(serviceId, SRV_NAME_CHAT)
	} else {
		conn, serviceId = services.GetService2(SRV_NAME_CHAT)
	}
	if conn == nil {
		log.Error("cannot get room service:", serviceId)
		return nil
	}

	cli := pb.NewChatServiceClient(conn)

	// 开启到聊天服务的流
	ctx := metadata.NewIncomingContext(
		context.Background(),
		metadata.New(map[string]string{
			"userid":       fmt.Sprint(sess.UserId),
			"service_name": SRV_NAME_CHAT,
			"service_id":   serviceId,
			"unique_id":    req.UniqueId,
			"is_reconnect": fmt.Sprint(req.IsReconnect),
		}),
	)
	stream, err := cli.Stream(ctx)
	if err != nil {
		log.Error(err)
		return nil
	}
	sess.Stream = stream
	sess.GSID = serviceId

	// 读取chat返回消息的goroutine
	fetcher_task := func(sess *Session) {
		for {
			in, err := sess.Stream.Recv()
			if err == io.EOF { // 流关闭
				log.Debug(err)
				return
			}
			if err != nil {
				log.Error(err)
				return
			}
			select {
			case sess.MQ <- *in:
			case <-sess.Die:
			}
		}
	}
	go fetcher_task(sess)

	// ping
	go func(sess *Session) {
		for {
			frame := &pb.Chat_Frame{
				Type:    pb.Chat_Ping,
				Message: []byte{},
			}

			// check stream
			if sess.Stream == nil {
				return
			}

			if err := sess.Stream.Send(frame); err != nil {
				log.Error("Send room ping frame error:", err)
				return
			}

			time.Sleep(5 * time.Second)
		}
	}(sess)
	log.Debug("user_login_ack: ", pb.UserLoginAck{
		BaseAck:   &pb.BaseAck{Ret: 1, Msg: "ok"},
		ServiceId: serviceId,
	})
	return packet.Pack(Code["user_login_ack"], &pb.UserLoginAck{
		BaseAck:   &pb.BaseAck{Ret: 1, Msg: "ok"},
		ServiceId: serviceId,
	})
}
