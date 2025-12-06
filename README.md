# 🌐 Device Wallpaper Flutter Plugin 

 [English](#english-version) | [简体中文](#简体中文-版本) 

 # 简体中文 版本 {#简体中文-版本} 

 ## 项目概述 
 一个 Flutter 插件，用于获取设备壁纸，支持 Android 上的静态和动态壁纸。该插件提供了简单易用的 API，允许开发者轻松访问设备当前的壁纸，并将其转换为可用的图像数据。适用于需要展示或处理设备壁纸的 Flutter 应用。 

 ## 核心特性 
 - ✅ **获取壁纸数据**：将当前设备壁纸转换为 Uint8List (PNG 格式)，方便在 Flutter 应用中使用
 - ✅ **静态壁纸支持**：完整支持获取设备上的静态壁纸
 - ✅ **动态壁纸支持**：对于动态壁纸，返回其缩略图（需要 Android 8.1+）
 - ✅ **Android 平台支持**：专门针对 Android 平台优化的实现
 - ✅ **简单易用 API**：仅需一行代码即可获取壁纸数据

 ## 安装指南 

 ### 环境要求 
 - Flutter SDK: ^3.3.0
 - Dart SDK: ^3.9.2
 - Android SDK: API 21+

 ### 安装步骤 
 1. 在 `pubspec.yaml` 文件中添加依赖：
    ```yaml
    dependencies:
      device_wallpaper_flutter: ^1.0.1
    ```

 2. 运行以下命令安装依赖：
    ```bash
    flutter pub get
    ```

 ## 使用说明 

 ### 基本用法 

 1. 导入包：
    ```dart
    import 'package:device_wallpaper_flutter/device_wallpaper_flutter.dart';
    ```

 2. 获取壁纸：
    ```dart
    import 'dart:typed_data';
    import 'package:flutter/material.dart';
    import 'package:device_wallpaper_flutter/device_wallpaper_flutter.dart';

    class WallpaperScreen extends StatefulWidget {
      const WallpaperScreen({super.key});

      @override
      State<WallpaperScreen> createState() => _WallpaperScreenState();
    }

    class _WallpaperScreenState extends State<WallpaperScreen> {
      Uint8List? _wallpaperBytes;
      bool _isLoading = false;

      Future<void> _getWallpaper() async {
        setState(() {
          _isLoading = true;
        });

        try {
          final Uint8List? wallpaper = await DeviceWallpaperFlutter.getWallpaper();
          setState(() {
            _wallpaperBytes = wallpaper;
          });
        } catch (e) {
          print('获取壁纸失败: $e');
        } finally {
          setState(() {
            _isLoading = false;
          });
        }
      }

      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('设备壁纸'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _isLoading
                    ? const CircularProgressIndicator()
                    : _wallpaperBytes != null
                        ? Image.memory(
                            _wallpaperBytes!,
                            width: 300,
                            height: 500,
                            fit: BoxFit.cover,
                          )
                        : const Text('无可用壁纸'),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _getWallpaper,
                  child: const Text('获取壁纸'),
                ),
              ],
            ),
          ),
        );
      }
    }
    ```

 ### API 参考 

 #### `DeviceWallpaperFlutter.getWallpaper()` 
 - **返回值**: `Future<Uint8List?>` - 壁纸字节数据，失败时返回 `null`
 - **支持平台**: 仅 Android
 - **行为**:
   - 对于静态壁纸：返回完整位图数据
   - 对于动态壁纸：返回缩略图（API 27+）
   - 若未设置壁纸：返回 `null`

 ## 贡献指南 

 ### 如何贡献 
 1. Fork 仓库
 2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
 3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
 4. 推送到分支 (`git push origin feature/AmazingFeature`)
 5. 打开 Pull Request

 ### 代码规范 
 - 遵循 Flutter 官方代码风格
 - 提交前运行 `flutter analyze` 确保无 lint 错误
 - 提交信息清晰明了，使用英文

 # English Version {#english-version} 

 ## Project Overview 
 A Flutter plugin to get device wallpaper, supporting static and live wallpapers on Android. This plugin provides a simple and easy-to-use API that allows developers to easily access the device's current wallpaper and convert it into usable image data. Suitable for Flutter applications that need to display or process device wallpapers. 

 ## Key Features 
 - ✅ **Get Wallpaper Data**: Convert current device wallpaper to Uint8List (PNG format) for easy use in Flutter applications
 - ✅ **Static Wallpaper Support**: Full support for getting static wallpapers on devices
 - ✅ **Live Wallpaper Support**: For live wallpapers, return their thumbnail (requires Android 8.1+)
 - ✅ **Android Platform Support**: Optimized implementation specifically for Android platform
 - ✅ **Simple API**: Only one line of code needed to get wallpaper data

 ## Installation Guide 

 ### Environment Requirements 
 - Flutter SDK: ^3.3.0
 - Dart SDK: ^3.9.2
 - Android SDK: API 21+

 ### Installation Steps 
 1. Add dependency to your `pubspec.yaml` file:
    ```yaml
    dependencies:
      device_wallpaper_flutter: ^1.0.1
    ```

 2. Run the following command to install dependencies:
    ```bash
    flutter pub get
    ```

 ## Usage Instructions 

 ### Basic Usage 

 1. Import the package:
    ```dart
    import 'package:device_wallpaper_flutter/device_wallpaper_flutter.dart';
    ```

 2. Get wallpaper:
    ```dart
    import 'dart:typed_data';
    import 'package:flutter/material.dart';
    import 'package:device_wallpaper_flutter/device_wallpaper_flutter.dart';

    class WallpaperScreen extends StatefulWidget {
      const WallpaperScreen({super.key});

      @override
      State<WallpaperScreen> createState() => _WallpaperScreenState();
    }

    class _WallpaperScreenState extends State<WallpaperScreen> {
      Uint8List? _wallpaperBytes;
      bool _isLoading = false;

      Future<void> _getWallpaper() async {
        setState(() {
          _isLoading = true;
        });

        try {
          final Uint8List? wallpaper = await DeviceWallpaperFlutter.getWallpaper();
          setState(() {
            _wallpaperBytes = wallpaper;
          });
        } catch (e) {
          print('Failed to get wallpaper: $e');
        } finally {
          setState(() {
            _isLoading = false;
          });
        }
      }

      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Device Wallpaper'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _isLoading
                    ? const CircularProgressIndicator()
                    : _wallpaperBytes != null
                        ? Image.memory(
                            _wallpaperBytes!,
                            width: 300,
                            height: 500,
                            fit: BoxFit.cover,
                          )
                        : const Text('No wallpaper available'),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _getWallpaper,
                  child: const Text('Get Wallpaper'),
                ),
              ],
            ),
          ),
        );
      }
    }
    ```

 ### API Reference 

 #### `DeviceWallpaperFlutter.getWallpaper()` 
 - **Returns**: `Future<Uint8List?>` - Wallpaper byte data, returns `null` if failed
 - **Supported Platforms**: Android only
 - **Behavior**:
   - For static wallpapers: Returns full bitmap data
   - For live wallpapers: Returns thumbnail (API 27+)
   - If no wallpaper is set: Returns `null`

 ## Contribution Guidelines 

 ### How to Contribute 
 1. Fork the repository
 2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
 3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
 4. Push to the branch (`git push origin feature/AmazingFeature`)
 5. Open a Pull Request

 ### Code Standards 
 - Follow Flutter official code style
 - Run `flutter analyze` before committing to ensure no lint errors
 - Use clear and concise commit messages in English
