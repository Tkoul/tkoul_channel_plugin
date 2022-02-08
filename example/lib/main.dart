import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:tkoul_channel_plugin/tkoul_channel_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion = "2";
    Map platformVersionse;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      if (Theme.of(context).platform == TargetPlatform.iOS) {
        //iOS端的例子
        Object result = await TkoulChannelPlugin()
            .objectTkoulChannelPlugin(callClassName: "AppDelegate", inputPar: {
          "type": "show",
          "msg":
              "第一个参数callClassName为注册类(AppDelegate),第二个参数inputPar，可以为数组，字典，字符串等数据类型"
        });
        print("ios端AppDelegate类=$result");
      } else {
        platformVersionse = await TkoulChannelPlugin().objectTkoulChannelPlugin(
            callClassName: "com.example.tkoul_channel_plugin_example.HelloWord",
            inputPar: [
              "第一个参数callClassName为注册类(com.example.tkoul_channel_plugin_example.HelloWord)，第二个参数inputPar为实际透传交互参数，可以为数组，字典，字符串等数据类型",
              "数组类型"
            ]);
        print("Andriod端HelloWord类===$platformVersionse");
      }
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('Running on: $_platformVersion\n'),
              IconButton(
                  onPressed: () async {
                    if (Theme.of(context).platform == TargetPlatform.android) {
                      Map myMap = await TkoulChannelPlugin()
                          .objectTkoulChannelPlugin(
                              callClassName:
                                  "com.example.tkoul_channel_plugin_example.MainActivity",
                              inputPar: [
                            "第一个参数callClassName为注册类(com.example.tkoul_channel_plugin_example.MainActivity),第二个参数inputPar，可以为数组，字典，字符串等数据类型"
                          ]);
                      setState(() {
                        _platformVersion = myMap["message"];
                      });
                    } else {
                      Map myMap = await TkoulChannelPlugin()
                          .objectTkoulChannelPlugin(
                              callClassName: "AppDelegate", inputPar: {"type":"flutterBtnClick","msg": "第一个参数callClassName为注册类(AppDelegate),第二个参数inputPar，可以为数组，字典，字符串等数据类型"});
                      setState(() {
                        _platformVersion = myMap["message"];
                      });
                    }
                  },
                  icon: Icon(Icons.send))
            ],
          ),
        ),
      ),
    );
  }
}
