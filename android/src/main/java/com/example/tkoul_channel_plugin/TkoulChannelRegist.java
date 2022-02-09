package com.example.tkoul_channel_plugin;

import java.util.ArrayList;

public class TkoulChannelRegist {
    //存放注册的类
    public ArrayList arryClass;
    //创建单利 用于全局使用
  private  static volatile    TkoulChannelRegist  singleInstance;
  private  TkoulChannelRegist(){};
  public static TkoulChannelRegist sharedInstance(){
    if (singleInstance==null){
      synchronized (TkoulChannelRegist.class){
        if (singleInstance==null){
          singleInstance = new TkoulChannelRegist();
          singleInstance.arryClass = new ArrayList();
        }
      }
    }
    return singleInstance;
  }

    //注册类型--相当注册协议  一旦被注册  该类具备通信能留
    public static void registerClassName(Class regClass){
        if (!TkoulChannelRegist.sharedInstance().arryClass.contains(regClass.getName())){
            TkoulChannelRegist.sharedInstance().arryClass.add(regClass.getName());
        }
    }
}
