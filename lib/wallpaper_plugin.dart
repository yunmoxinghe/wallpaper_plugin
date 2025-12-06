import 'dart:typed_data';
import 'wallpaper_plugin_platform_interface.dart';

class WallpaperPlugin {
  static Future<Uint8List?> getWallpaper() {
    return WallpaperPluginPlatform.instance.getWallpaper();
  }
}
