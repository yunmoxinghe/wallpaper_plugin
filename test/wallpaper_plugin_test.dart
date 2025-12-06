import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:wallpaper_plugin/wallpaper_plugin.dart';
import 'package:wallpaper_plugin/wallpaper_plugin_platform_interface.dart';
import 'package:wallpaper_plugin/wallpaper_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockWallpaperPluginPlatform
    with MockPlatformInterfaceMixin
    implements WallpaperPluginPlatform {

  @override
  Future<Uint8List?> getWallpaper() => Future.value(Uint8List.fromList([1, 2, 3, 4, 5]));
}

void main() {
  final WallpaperPluginPlatform initialPlatform = WallpaperPluginPlatform.instance;

  test('$MethodChannelWallpaperPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelWallpaperPlugin>());
  });

  test('getWallpaper', () async {
    MockWallpaperPluginPlatform fakePlatform = MockWallpaperPluginPlatform();
    WallpaperPluginPlatform.instance = fakePlatform;

    expect(await WallpaperPlugin.getWallpaper(), isA<Uint8List>());
  });
}
