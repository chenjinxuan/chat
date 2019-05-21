package com.example.administrator.chat.activitys;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.widget.ImageView;

import com.bumptech.glide.Glide;
import com.example.administrator.chat.ChatSessionCom.MyImageLoader;
import com.example.administrator.chat.ChatSessionCom.MyMessage;
import com.example.administrator.chat.R;

import cn.jiguang.imui.commons.ImageLoader;
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
        ImageLoader imageLoader = new MyImageLoader(getApplicationContext());
        adapter = new MsgListAdapter<MyMessage>("0", imageLoader);
        messageList.setAdapter(adapter);
        MyMessage myMessage = new MyMessage("hello,worldsdfsdfsdfsdf李厚霖压顶无可奈何花落去李厚霖" +
                "李厚霖压顶无可奈何花落去李厚霖压顶无可奈何花落去大规模 李厚霖压顶地李厚霖压顶地", 0);
        adapter.addToStart(myMessage, true);
        adapter.addToStart(myMessage, true);
        adapter.addToStart(myMessage, true);
    }

    @Override
    public void onBackPressed() {
        // 禁用默认回退效果
    }
}