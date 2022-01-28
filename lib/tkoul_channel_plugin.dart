import 'dart:async';

import 'package:flutter/services.dart';

class TkoulChannelPlugin<T> {
  static const MethodChannel _channel = MethodChannel('tkoul_channel_plugin');

  Future<T?> objectTkoulChannelPlugin(String callClassName,
      {required Object inputPar}) async {
    List inpuArguments = [callClassName, inputPar];
    final T? object = await _channel
        .invokeMethod('objectTkoulChannelPlugin', inpuArguments);
    return object;
  }
}
