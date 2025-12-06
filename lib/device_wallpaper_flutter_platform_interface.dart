import 'dart:typed_data';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'device_wallpaper_flutter_method_channel.dart';

abstract class DeviceWallpaperFlutterPlatform extends PlatformInterface {
  DeviceWallpaperFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static DeviceWallpaperFlutterPlatform _instance = MethodChannelDeviceWallpaperFlutter();

  static DeviceWallpaperFlutterPlatform get instance => _instance;

  static set instance(DeviceWallpaperFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// ✨ 你必须在这里定义抽象方法！
  Future<Uint8List?> getWallpaper() {
    throw UnimplementedError('getWallpaper() has not been implemented.');
  }
}
