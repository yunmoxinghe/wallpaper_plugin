import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'device_wallpaper_flutter_platform_interface.dart';

/// An implementation of [DeviceWallpaperFlutterPlatform] that uses method channels.
class MethodChannelDeviceWallpaperFlutter extends DeviceWallpaperFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('device_wallpaper_flutter');

  @override
  Future<Uint8List?> getWallpaper() async {
    final bytes = await methodChannel.invokeMethod<Uint8List>('getWallpaper');
    return bytes;
  }
}
