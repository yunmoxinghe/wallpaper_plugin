# 🌐 Device Wallpaper Flutter Plugin

[English](README.md) | [简体中文](README_zh.md)

---

<div align="center">

![Pub Version](https://img.shields.io/pub/v/device_wallpaper_flutter)
![Platform](https://img.shields.io/badge/platform-Android-blue)
![License](https://img.shields.io/badge/license-MIT-green)

</div>

---

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