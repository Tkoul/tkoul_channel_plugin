package com.example.tkoul_channel_plugin;

import androidx.annotation.NonNull;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** TkoulChannelPlugin */
public class TkoulChannelPlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "tkoul_channel_plugin");
    channel.setMethodCallHandler(this);
  }
  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull final Result result) {
    String method = call.method;
    if (method == null) {
      result.notImplemented();
      return;
    }

    ArrayList arguments = (ArrayList) call.arguments;
    String className = !arguments.isEmpty()?(String) arguments.get(0):"";
    ArrayList  arryClass = TkoulChannelRegist.sharedInstance().arryClass;
    if (arryClass.contains(className)) {
      Class classDo = null;
      try {
        classDo = Class.forName(className);
      } catch (ClassNotFoundException e) {
        e.printStackTrace();
      }
      try {
        Method methodGet = classDo.getMethod("tkoulChannlePlugin", Object.class, TkoulChannelBlock.class);
        methodGet.invoke(classDo, arguments.size()>=2?arguments.get(1):new ArrayList(), new TkoulChannelBlock() {
          @Override
          public void channelBlock(Map resultMesg) {
            result.success(resultMesg);
          }
        });
      } catch (NoSuchMethodException e) {
        e.printStackTrace();
      } catch (IllegalAccessException e) {
        e.printStackTrace();
      } catch (InvocationTargetException e) {
        e.printStackTrace();
      }
    }else {
      Map errorMap = new HashMap();
      errorMap.put("code","-1");
      errorMap.put("msg","未找到原生andriod注册类或者类名错误，包括路径错误");
      result.success(errorMap);
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
