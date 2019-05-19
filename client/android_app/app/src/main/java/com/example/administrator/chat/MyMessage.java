package com.example.administrator.chat;

import android.app.Notification;

import java.util.HashMap;
import java.util.UUID;

import cn.jiguang.imui.commons.models.IMessage;
import cn.jiguang.imui.commons.models.IUser;

public class MyMessage implements IMessage {

    private long id;
    private String text;
    private String timeString;
    private MessageType type;
    private IUser user;
    private String mediaFilePath;
    private long duration;
    private String progress;
    private Notification.MessagingStyle.Message message;
    private int position;
    private long msgID;

    public MyMessage(String text, MessageType type) {
        this.text = text;
        this.type = type;
        this.id = UUID.randomUUID().getLeastSignificantBits();
    }

    @Override
    public String getMsgId() {
        return null;
    }

    @Override
    public IUser getFromUser() {
        return null;
    }

    @Override
    public String getTimeString() {
        return null;
    }

    @Override
    public int getType() {
        return 0;
    }

    @Override
    public MessageStatus getMessageStatus() {
        return null;
    }

    @Override
    public String getText() {
        return null;
    }

    @Override
    public String getMediaFilePath() {
        return null;
    }

    @Override
    public long getDuration() {
        return 0;
    }

    @Override
    public String getProgress() {
        return null;
    }

    @Override
    public HashMap<String, String> getExtras() {
        return null;
    }
}