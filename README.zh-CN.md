# Device Wallpaper Flutter Plugin

[English](#device-wallpaper-flutter-plugin)

一个 Flutter 插件，用于获取设备壁纸，支持 Android 上的静态和动态壁纸。

## 简体中文 介绍

## 功能特性

- ✅ 获取当前设备壁纸为 Uint8List (PNG 格式)
- ✅ 支持静态壁纸
- ✅ 支持动态壁纸（返回缩略图）
- ✅ Android 平台支持

## 平台支持

| 平台 | 状态 |
|------|------|
| Android | ✅ |
| iOS | ❌ |
| Web | ❌ |
| Linux | ❌ |
| macOS | ❌ |
| Windows | ❌ |

## 安装

在你的 `pubspec.yaml` 文件中添加 `device_wallpaper_flutter`：

```yaml
dependencies:
  device_wallpaper_flutter: ^1.0.1
```

然后运行：

```bash
flutter pub get
```

## 使用方法

### 导入包

```dart
import 'package:device_wallpaper_flutter/device_wallpaper_flutter.dart';
```

### 获取当前壁纸

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

## API 参考

### `DeviceWallpaperFlutter.getWallpaper()`

返回当前设备壁纸，格式为 PNG 的 `Uint8List`。

- **返回值**: `Future<Uint8List?>` - 壁纸字节或失败时返回 `null`
- **支持平台**: 仅 Android
- **行为**:
  - 对于静态壁纸: 返回完整位图
  - 对于动态壁纸: 返回缩略图（API 27+）
  - 若未设置壁纸: 返回 `null`

## 权限

### Android

此插件不需要额外的权限。必要的权限已在内部处理。

## 实现细节

### Android

- 使用 `WallpaperManager` 访问设备壁纸
- 对于动态壁纸（API 27+），尝试使用 `getBuiltInDrawable()` 获取缩略图
- 如果缩略图不可用，则回退到当前 drawable
- 在返回前将 drawable 转换为 PNG 格式字节

## 限制

- 仅支持 Android 平台
- 动态壁纸支持需要 Android 8.1+（API 27+）
- 不支持设置壁纸，仅支持获取
- 不支持分别获取锁屏和主屏幕壁纸

## 贡献

欢迎贡献！请随时提交 Pull Request。

## 许可证

MIT

## 问题反馈

请在 [GitHub Issues](https://github.com/yunmoxinghe/wallpaper_plugin/issues) 中提交问题、错误或功能请求。
