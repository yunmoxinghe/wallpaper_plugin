import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:device_wallpaper_flutter/device_wallpaper_flutter_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('MethodChannelDeviceWallpaperFlutter', () {
    late MethodChannelDeviceWallpaperFlutter methodChannelDeviceWallpaperFlutter;
    const MethodChannel channel = MethodChannel('device_wallpaper_flutter');

    setUp(() {
      methodChannelDeviceWallpaperFlutter = MethodChannelDeviceWallpaperFlutter();
      
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
      expect(await methodChannelDeviceWallpaperFlutter.getWallpaper(), isA<Uint8List>());
    });
  });
}
