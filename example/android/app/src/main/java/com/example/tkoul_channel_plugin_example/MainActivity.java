package com.example.tkoul_channel_plugin_example;


import android.app.LoaderManager;
import android.os.Bundle;
import android.os.PersistableBundle;

import androidx.annotation.Nullable;

import io.flutter.Log;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;

import com.example.tkoul_channel_plugin.TkoulChannelBlock;
import com.example.tkoul_channel_plugin.TkoulChannelPlugin;
import com.example.tkoul_channel_plugin.TkoulChannelRegist;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class MainActivity extends FlutterActivity {

    public  static void registThisClass(){
        TkoulChannelRegist.registerClassName(MainActivity.class);
    }

    static  int a = 4;
    public  static void  tkoulChannlePlugin(Object arguments, TkoulChannelBlock b){
        a++;
        Log.e("传进来的参数是",arguments.toString());
        if (b != null) {
            ArrayList  lsit = new ArrayList();
            lsit.add("back");
            lsit.add("back2");
            lsit.add("back3");
            Map ksks = new HashMap();
            ksks.put("code","1");
            ksks.put("list",lsit);
            ksks.put("message","buautiful"+a);
            b.channelBlock(ksks);

        }
    }
}

