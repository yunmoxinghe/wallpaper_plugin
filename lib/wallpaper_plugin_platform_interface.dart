import 'dart:typed_data';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'wallpaper_plugin_method_channel.dart';

abstract class WallpaperPluginPlatform extends PlatformInterface {
  WallpaperPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static WallpaperPluginPlatform _instance = MethodChannelWallpaperPlugin();

  static WallpaperPluginPlatform get instance => _instance;

  static set instance(WallpaperPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// ✨ 你必须在这里定义抽象方法！
  Future<Uint8List?> getWallpaper() {
    throw UnimplementedError('getWallpaper() has not been implemented.');
  }
}
