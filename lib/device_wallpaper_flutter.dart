import 'dart:typed_data';
import 'device_wallpaper_flutter_platform_interface.dart';

class DeviceWallpaperFlutter {
  static Future<Uint8List?> getWallpaper() {
    return DeviceWallpaperFlutterPlatform.instance.getWallpaper();
  }
}
