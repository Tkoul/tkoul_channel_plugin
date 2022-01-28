package com.example.tkoul_channel_plugin_example;

import com.example.tkoul_channel_plugin.TkoulChannelBlock;
import com.example.tkoul_channel_plugin.TkoulChannelPlugin;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import io.flutter.Log;

public class HelloWord {

    public  static void  tkoulChannlePlugin(Object arguments, TkoulChannelBlock b){
        Log.e("传进来的参数是",arguments.toString());
        if (b != null) {
            Map ksks = new HashMap();
            ksks.put("code","1");
            ksks.put("message","success");
            b.channelBlock(ksks);

        }
    }

}
