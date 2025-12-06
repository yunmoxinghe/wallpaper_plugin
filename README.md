# device_wallpaper_flutter

A Flutter plugin to get device wallpaper, supporting static and live wallpapers on Android.

## Features

- ✅ Get device wallpaper as Uint8List bytes
- ✅ Support for static wallpapers
- ✅ Support for live wallpapers (returns thumbnail)
- ✅ Android platform support
- ✅ Easy to use API
- ✅ Example app included

## Supported Platforms

- Android

## Installation

Add `device_wallpaper_flutter` to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  device_wallpaper_flutter: ^1.0.1
```

Then run `flutter pub get` to install the plugin.

## Usage

### Basic Usage

```dart
import 'package:flutter/material.dart';
import 'package:device_wallpaper_flutter/device_wallpaper_flutter.dart';
import 'dart:typed_data';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Uint8List? _wallpaper;
  String _error = '';

  @override
  void initState() {
    super.initState();
    loadWallpaper();
  }

  Future<void> loadWallpaper() async {
    try {
      final bytes = await DeviceWallpaperFlutter.getWallpaper();
      setState(() {
        _wallpaper = bytes;
        _error = '';
      });
    } on PlatformException {
      setState(() {
        _error = 'Failed to load wallpaper.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Wallpaper Plugin Example'),
        ),
        body: Center(
          child: _error.isNotEmpty
              ? Text(_error)
              : _wallpaper == null
                  ? const CircularProgressIndicator()
                  : Image.memory(_wallpaper!),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: loadWallpaper,
          tooltip: 'Refresh Wallpaper',
          child: const Icon(Icons.refresh),
        ),
      ),
    );
  }
}
```

### Permission Handling

On Android, you need to request permissions to access media files. For Android 13+ (`API 33+`), use `READ_MEDIA_IMAGES` permission. For older versions, use `READ_EXTERNAL_STORAGE` permission.

Add the following to your `AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.READ_MEDIA_IMAGES" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" android:maxSdkVersion="32" />
```

You can use the `permission_handler` package to request permissions at runtime.

## API Reference

### `DeviceWallpaperFlutter.getWallpaper()`

Returns the device wallpaper as `Uint8List` bytes.

- **Returns**: `Future<Uint8List?>` - The wallpaper bytes, or `null` if failed to get wallpaper
- **Throws**: `PlatformException` - If there's an error getting the wallpaper

## Example App

The plugin includes an example app that demonstrates how to use the device_wallpaper_flutter. To run the example app:

1. Clone the repository
2. Navigate to the `example` directory
3. Run `flutter pub get`
4. Run `flutter run`

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

MIT

## Issues

Please file any issues, bugs or feature requests as an issue on our [GitHub](https://github.com/yunmoxinghe/wallpaper_plugin) repository.

## Author

[云漠星河] (https://github.com/yunmoxinghe)

