package com.example.administrator.chat.ChatSessionCom;

import android.content.Context;
import android.widget.ImageView;

import com.bumptech.glide.Glide;

import cn.jiguang.imui.commons.ImageLoader;

public class MyImageLoader implements ImageLoader {
    private Context context;

    public MyImageLoader(Context context){
        this.context = context;
    }

    @Override
    public void loadAvatarImage(ImageView avatarImageView, String string) {
        Glide.with(this.context)
                .load(string)
                .into(avatarImageView);
    }

    @Override
    public void loadImage(ImageView imageView, String string) {
        Glide.with(this.context)
                .load(string)
                .into(imageView);
    }

    @Override
    public void loadVideo(ImageView imageCover, String uri) {

    }
}
