import {Divider, Text} from 'react-native-elements';
import {Component} from "react";
import * as React from "react";
import {View} from "react-native";

let IMUI = require('aurora-imui-react-native');
let MessageList = IMUI.MessageList;
let ChatInput = IMUI.ChatInput;
const AuroraIMUIController = IMUI.AuroraIMUIController; // the IMUI controller, use it to operate  messageList and ChatInput.

interface UserMsg {
    id: number,
    text: string
    senderUserID: number,
}

interface State {
    msgArr: UserMsg[],
}

var messages = [{
    msgId: "1",
    status: "send_going",
    msgType: "text",
    text: "Hello world",
    isOutgoing: true,
    fromUser: {
        userId: "1",
        displayName: "Ken",
        avatarPath: "ironman"
    },
    timeString: "10:00",
}];
AuroraIMUIController.appendMessages(messages);

export class TalkSession extends Component<any, State> {
    constructor(props: any) {
        super(props);
        this.state = {
            msgArr: [],
        }
    }

    render(): React.ReactNode {
        return (
            <View style={{}}>
                <Text>你好</Text>
                <MessageList
                    style={{flex: 1}}
                    onMsgClick={() => this.onMsgClick()}
                    onMsgLongClick={() => this.onMsgLongClick()}
                    onAvatarClick={() => this.onAvatarClick()}
                    onStatusViewClick={() => this.onStatusViewClick()}
                    onTouchMsgList={() => this.onTouchMsgList()}
                    onPullToRefresh={() => this.onPullToRefresh()}
                    sendBubble={{imageName: "send_msg", padding: 10}}
                    receiveBubbleTextColor={'#ffffff'}
                    sendBubbleTextSize={18}
                    receiveBubbleTextSize={14}
                    sendBubblePressedColor={'#dddddd'}
                />
                <ChatInput
                    // style={{backgroundColor:"#000"}}
                    // menuContainerHeight={40.0}
                    // isDismissMenuContainer={true}
                    // onSendText={() => this.onSendText()}
                    // onSendGalleryFiles={() => this.onSendGalleryFiles()}
                    // onTakePicture={() => this.onTakePicture()}
                    // onStartRecordVideo={() => this.onStartRecordVideo()}
                    // onFinishRecordVideo={() => this.onFinishRecordVideo()}
                    // onCancelRecordVideo={() => this.onCancelRecordVideo()}
                    // onStartRecordVoice={() => this.onStartRecordVoice()}
                    // onFinishRecordVoice={() => this.onFinishRecordVoice()}
                    // onCancelRecordVoice={() => this.onCancelRecordVoice()}
                    // onSwitchToMicrophoneMode={() => this.onSwitchToMicrophoneMode()}
                    // onSwitchToGalleryMode={() => this.onSwitchToGalleryMode()}
                    // onSwitchToCameraMode={() => this.onSwitchToCameraMode()}
                    // onTouchEditText={() => this.onTouchEditText()}

                />
                <Text > 我是结尾</Text>
            </View>
        )
    }


    private onMsgClick() {
        return undefined;
    }

    private onMsgLongClick() {
        return undefined;
    }

    private onAvatarClick() {
        return undefined;
    }

    private onStatusViewClick() {
        return undefined;
    }

    private onTouchMsgList() {
        return undefined;
    }

    private onPullToRefresh() {
        return undefined;
    }

    private onSendText() {
        return undefined;
    }

    private onSendGalleryFiles() {
        return undefined;
    }

    private onTakePicture() {
        return undefined;
    }

    private onStartRecordVideo() {
        return undefined;
    }

    private onFinishRecordVideo() {
        return undefined;
    }

    private onCancelRecordVideo() {
        return undefined;
    }

    private onStartRecordVoice() {
        return undefined;
    }

    private onFinishRecordVoice() {
        return undefined;
    }

    private onCancelRecordVoice() {
        return undefined;
    }

    private onSwitchToMicrophoneMode() {
        return undefined;
    }

    private onSwitchToGalleryMode() {
        return undefined;
    }

    private onSwitchToCameraMode() {
        return undefined;
    }

    private onTouchEditText() {
        return undefined;
    }
}