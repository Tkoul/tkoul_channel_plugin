import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tkoul_channel_plugin/tkoul_channel_plugin.dart';

void main() {
  const MethodChannel channel = MethodChannel('tkoul_channel_plugin');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await TkoulChannelPlugin.platformVersion, '42');
  });
}
