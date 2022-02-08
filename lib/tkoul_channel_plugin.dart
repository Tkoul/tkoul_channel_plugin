import 'dart:async';

import 'package:flutter/services.dart';

class TkoulChannelPlugin {
  static const MethodChannel _channel = MethodChannel('tkoul_channel_plugin');
  //通用方法 查看MethodChannel 有很通信方法-目的都一致   为了统一便捷，这里仅使用一种即可。
  //约定规则  第一个参数传类名，第二个为实际参数。返回值为Map。并且每个返回值key均有code。0为成功-1位异常，其它key根据自己需要自行添加。
  Future<Map> objectTkoulChannelPlugin(
      {required String callClassName, required Object inputPar}) async {
    List inpuArguments = [callClassName, inputPar];
    final Map result = await _channel.invokeMapMethod(
            'objectTkoulChannelPlugin', inpuArguments) ??
        {"code": "-1", "msg": "通信失败"};
    return result;
  }
}
