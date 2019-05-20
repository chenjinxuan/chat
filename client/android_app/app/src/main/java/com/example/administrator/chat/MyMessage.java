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
    private int type;
    private IUser user;
    private String contentFile;
    private long duration;

    public MyMessage(String text, int type) {
        this.text = text;
        this.type = type;
        this.id = UUID.randomUUID().getLeastSignificantBits();
    }

    @Override
    public String getMsgId() {
        return String.valueOf(id);
    }

    @Override
    public IUser getFromUser() {
        if (user == null) {
            return new DefaultUser("0", "user1", null);
        }
        return user;
    }

    public void setUserInfo(IUser user) {
        this.user = user;
    }

    public void setMediaFilePath(String path) {
        this.contentFile = path;
    }

    public void setDuration(long duration) {
        this.duration = duration;
    }

    @Override
    public long getDuration() {
        return duration;
    }

    @Override
    public String getProgress() {
        return null;
    }

    @Override
    public HashMap<String, String> getExtras() {
        return null;
    }

    public void setTimeString(String timeString) {
        this.timeString = timeString;
    }

    @Override
    public String getTimeString() {
        return timeString;
    }

    @Override
    public int getType() {
        return type;
    }

    @Override
    public MessageStatus getMessageStatus() {
        return null;
    }

    @Override
    public String getText() {
        return text;
    }

    @Override
    public String getMediaFilePath() {
        return contentFile;
    }
}