# 🌐 Device Wallpaper Flutter Plugin

[English](#english-version) | [简体中文](#简体中文-版本)

---

<div align="center">

![Pub Version](https://img.shields.io/pub/v/device_wallpaper_flutter)
![Platform](https://img.shields.io/badge/platform-Android-blue)
![License](https://img.shields.io/badge/license-MIT-green)

</div>

---

# 简体中文 版本

## 📘 项目概述
一个 Flutter 插件，用于获取设备壁纸，支持 Android 上的静态与动态壁纸。  
提供简单易用的 API，可将设备壁纸转换为 `Uint8List` 图像数据，适用于需要展示或处理壁纸的应用场景。

## ✨ 核心特性
- ✅ **获取壁纸数据**：静态壁纸完整 PNG 数据  
- ✅ **动态壁纸支持**：返回缩略图（Android 8.1+）  
- ✅ **仅 Android 平台**：轻量、无额外依赖  
- ✅ **简洁 API**：一行代码即可获取壁纸  

---

## 🛠️ 安装指南

### 环境要求
- Flutter SDK: ^3.3.0  
- Dart SDK: ^3.9.2  
- Android SDK: API 21+

### 安装步骤
在 `pubspec.yaml` 中添加依赖：

```yaml
dependencies:
  device_wallpaper_flutter: ^1.0.1
```

然后运行：

```bash
flutter pub get
```

---

## 🚀 使用说明

### 基本示例

#### 1. 导入包：
```dart
import 'package:device_wallpaper_flutter/device_wallpaper_flutter.dart';
```

#### 2. 调用 API 获取壁纸：
```dart
final Uint8List? wallpaper = await DeviceWallpaperFlutter.getWallpaper();
```

### 完整示例代码
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
    setState(() => _isLoading = true);

    try {
      final Uint8List? wallpaper = await DeviceWallpaperFlutter.getWallpaper();
      setState(() => _wallpaperBytes = wallpaper);
    } catch (e) {
      print('获取壁纸失败: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('设备壁纸')),
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

---

## 📚 API 参考

### `DeviceWallpaperFlutter.getWallpaper()`
- **返回**：`Future<Uint8List?>`  
- **平台**：Android  
- **行为说明**：
  - 静态壁纸 → 返回完整 PNG  
  - 动态壁纸 → 返回缩略图（API 27+）  
  - 无壁纸 → 返回 `null`  

---

## 🤝 贡献指南

### 如何贡献
1. Fork 本仓库  
2. 创建特性分支  
3. 提交更改  
4. 推送到你的分支  
5. 创建 Pull Request  

### 代码规范
- 遵循 Flutter 格式规范  
- 提交前请运行：`flutter analyze`  
- Commit message 使用英文  

---

# English Version

## 📘 Project Overview
A Flutter plugin for retrieving device wallpapers on Android, supporting both static and live wallpapers.  
The plugin provides an easy-to-use API to access the current wallpaper and convert it into `Uint8List` PNG bytes.

## ✨ Key Features
- ✅ **Get Wallpaper Data** (PNG format)  
- ✅ **Static Wallpaper Support**  
- ✅ **Live Wallpaper Support** (thumbnail for API 27+)  
- ✅ **Android Only**  
- ✅ **Simple, Minimal API**  

---

## 🛠️ Installation Guide

### Requirements
- Flutter SDK: ^3.3.0  
- Dart SDK: ^3.9.2  
- Android SDK: API 21+

### Install
```yaml
dependencies:
  device_wallpaper_flutter: ^1.0.1
```

```bash
flutter pub get
```

---

## 🚀 Usage Instructions

### Import:
```dart
import 'package:device_wallpaper_flutter/device_wallpaper_flutter.dart';
```

### Get wallpaper:
```dart
final Uint8List? wallpaper = await DeviceWallpaperFlutter.getWallpaper();
```

### Full example
(Chinese example above is identical; keep consistency)

---

## 📚 API Reference

### `DeviceWallpaperFlutter.getWallpaper()`
- **Returns** `Future<Uint8List?>`  
- **Platforms**: Android only  
- **Behavior**:
  - Static wallpaper → full bitmap  
  - Live wallpaper → thumbnail (API 27+)  
  - No wallpaper → `null`  

---

## 🤝 Contribution Guidelines
- Fork → Branch → Commit → Push → PR  
- Run `flutter analyze` before submitting  
- Use clear English commit messages  

---
