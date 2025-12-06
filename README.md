# Device Wallpaper Flutter Plugin

[简体中文](#简体中文-介绍)

A Flutter plugin to get device wallpaper, supporting static and live wallpapers on Android.

## Features

- ✅ Get current device wallpaper as Uint8List (PNG format)
- ✅ Support for static wallpapers
- ✅ Support for live wallpapers (returns thumbnail)
- ✅ Android platform support

## Platform Support

| Platform | Status |
|----------|--------|
| Android  | ✅      |
| iOS      | ❌      |
| Web      | ❌      |
| Linux    | ❌      |
| macOS    | ❌      |
| Windows  | ❌      |

## Installation

Add `device_wallpaper_flutter` to your `pubspec.yaml` file:

```yaml
dependencies:
  device_wallpaper_flutter: ^1.0.1
```

Then run:

```bash
flutter pub get
```

## Usage

### Import the package

```dart
import 'package:device_wallpaper_flutter/device_wallpaper_flutter.dart';
```

### Get the current wallpaper

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

## API Reference

### `DeviceWallpaperFlutter.getWallpaper()`

Returns the current device wallpaper as a `Uint8List` in PNG format.

- **Returns**: `Future<Uint8List?>` - The wallpaper bytes or `null` if failed
- **Platforms**: Android only
- **Behavior**:
  - For static wallpapers: Returns the full bitmap
  - For live wallpapers: Returns a thumbnail (API 27+)
  - If no wallpaper is set: Returns `null`

## Permissions

### Android

No additional permissions are required for this plugin. The necessary permissions are handled internally.

## Implementation Details

### Android

- Uses `WallpaperManager` to access the device wallpaper
- For live wallpapers (API 27+), tries to get a thumbnail using `getBuiltInDrawable()`
- Falls back to the current drawable if thumbnail is not available
- Converts drawables to PNG format bytes before returning

## Limitations

- Only supports Android platform
- Live wallpaper support requires Android 8.1+ (API 27+)
- Does not support setting wallpapers, only retrieving them
- Does not support getting lock screen vs home screen wallpapers separately

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

MIT

## Issues

Please file issues, bugs, or feature requests in [GitHub Issues](https://github.com/yourusername/device_wallpaper_flutter/issues).
