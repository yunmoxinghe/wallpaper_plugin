import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wallpaper_plugin/wallpaper_plugin_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelWallpaperPlugin platform = MethodChannelWallpaperPlugin();
  const MethodChannel channel = MethodChannel('wallpaper_plugin');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return Uint8List.fromList([1, 2, 3, 4, 5]);
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getWallpaper', () async {
    expect(await platform.getWallpaper(), isA<Uint8List>());
  });
}
