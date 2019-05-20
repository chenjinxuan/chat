package com.example.administrator.chat;

import android.content.Context;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.widget.ImageView;

import com.bumptech.glide.Glide;

import cn.jiguang.imui.commons.ImageLoader;
import cn.jiguang.imui.commons.models.IMessage;
import cn.jiguang.imui.messages.MessageList;
import cn.jiguang.imui.messages.MsgListAdapter;

public class ChatSession extends AppCompatActivity {
    MessageList messageList;
    MsgListAdapter<MyMessage> adapter;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_chat_session);
        findViewById(R.id.chat_input);
        messageList = findViewById(R.id.msg_list);
        ImageLoader imageLoader = new ImageLoader() {
            @Override
            public void loadAvatarImage(ImageView avatarImageView, String string) {
                Glide.with(getApplicationContext())
                        .load(string)
                        .into(avatarImageView);
            }

            @Override
            public void loadImage(ImageView imageView, String string) {
                Glide.with(getApplicationContext())
                        .load(string)
                        .into(imageView);
            }

            @Override
            public void loadVideo(ImageView imageCover, String uri) {

            }
        };
        adapter = new MsgListAdapter<MyMessage>("0", imageLoader);
        messageList.setAdapter(adapter);
        MyMessage myMessage = new MyMessage("hello,worldsdfsdfsdfsdf李厚霖压顶无可奈何花落去李厚霖" +
                "李厚霖压顶无可奈何花落去李厚霖压顶无可奈何花落去大规模 李厚霖压顶地李厚霖压顶地", 0);
        adapter.addToStart(myMessage, true);
        adapter.addToStart(myMessage, true);
        adapter.addToStart(myMessage, true);
    }
}