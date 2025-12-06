import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:device_wallpaper_flutter/device_wallpaper_flutter.dart';
import 'package:device_wallpaper_flutter/device_wallpaper_flutter_platform_interface.dart';
import 'package:device_wallpaper_flutter/device_wallpaper_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDeviceWallpaperFlutterPlatform
    with MockPlatformInterfaceMixin
    implements DeviceWallpaperFlutterPlatform {

  @override
  Future<Uint8List?> getWallpaper() => Future.value(Uint8List.fromList([1, 2, 3, 4, 5]));
}

void main() {
  final DeviceWallpaperFlutterPlatform initialPlatform = DeviceWallpaperFlutterPlatform.instance;

  test('$MethodChannelDeviceWallpaperFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDeviceWallpaperFlutter>());
  });

  test('getWallpaper', () async {
    MockDeviceWallpaperFlutterPlatform fakePlatform = MockDeviceWallpaperFlutterPlatform();
    DeviceWallpaperFlutterPlatform.instance = fakePlatform;

    expect(await DeviceWallpaperFlutter.getWallpaper(), isA<Uint8List>());
  });
}
