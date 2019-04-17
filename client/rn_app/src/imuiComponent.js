import IMUI from 'aurora-imui-react-native';
var MessageList = IMUI.MessageList;
var ChatInput = IMUI.ChatInput;
const AuroraIMUIModule = NativeModules.AuroraIMUIModule;
import React, { Component } from 'react';
import { Text, View } from 'react-native';

export default class ImuiComponent extends Component {
    render(): React.ReactNode {
        return (
            <View style = { styles.container }>
                <MessageList
                    style = {{flex: 1}}
                    onMsgClick = {this.onMsgClick}
                    onMsgLongClick = {this.onMsgLongClick}
                    onAvatarClick = {this.onAvatarClick}
                    onStatusViewClick = {this.onStatusViewClick}
                    onTouchMsgList = {this.onTouchMsgList}
                    onPullToRefresh = {this.onPullToRefresh}
                    sendBubble = {{imageName:"send_msg", padding: 10}}
                    receiveBubbleTextColor = {'#ffffff'}
                    sendBubbleTextSize = {18}
                    receiveBubbleTextSize = {14}
                    sendBubblePressedColor = {'#dddddd'}
                />
                    <ChatInput
                        style = {this.state.chatInputStyle}
                        menuContainerHeight = {this.state.menuContainerHeight}
                        isDismissMenuContainer = {this.state.isDismissMenuContainer}
                        onSendText = {this.onSendText}
                        onSendGalleryFiles = {this.onSendGalleryFiles}
                        onTakePicture = {this.onTakePicture}
                        onStartRecordVideo = {this.onStartRecordVideo}
                        onFinishRecordVideo = {this.onFinishRecordVideo}
                        onCancelRecordVideo = {this.onCancelRecordVideo}
                        onStartRecordVoice = {this.onStartRecordVoice}
                        onFinishRecordVoice = {this.onFinishRecordVoice}
                        onCancelRecordVoice = {this.onCancelRecordVoice}
                        onSwitchToMicrophoneMode = {this.onSwitchToMicrophoneMode}
                        onSwitchToGalleryMode = {this.onSwitchToGalleryMode}
                        onSwitchToCameraMode = {this.onSwitchToCameraMode}
                        onTouchEditText = {this.onTouchEditText}
                    />
            </View>
        );
    }
}