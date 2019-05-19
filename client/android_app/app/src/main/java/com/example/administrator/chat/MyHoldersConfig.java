package com.example.administrator.chat;


import android.view.View;

import cn.jiguang.imui.commons.models.IMessage;
import cn.jiguang.imui.messages.BaseMessageViewHolder;
import cn.jiguang.imui.messages.MessageListStyle;
import cn.jiguang.imui.messages.MsgListAdapter;

public class MyHoldersConfig<MESSAGE extends IMessage>
        extends BaseMessageViewHolder<MESSAGE>
        implements MsgListAdapter.DefaultMessageViewHolder {

    public MyHoldersConfig(View itemView, boolean isSender) {
        super(itemView);

    }

    @Override
    public void onBind(final MESSAGE message) {

    }

    @Override
    public void applyStyle(MessageListStyle style) {

    }
}