import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wallpaper_plugin/wallpaper_plugin.dart';

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
  bool _hasPermission = false;

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  Future<void> _checkPermission() async {
    PermissionStatus status;
    if (await Permission.storage.isGranted || 
        await Permission.photos.isGranted) {
      status = PermissionStatus.granted;
    } else {
      status = await _requestPermission();
    }
    
    setState(() {
      _hasPermission = status.isGranted;
    });
    
    if (_hasPermission) {
      loadWallpaper();
    }
  }

  Future<PermissionStatus> _requestPermission() async {
    Permission permission;
    if (await Permission.storage.shouldShowRequestRationale) {
      permission = Permission.storage;
    } else {
      permission = Permission.photos;
    }
    return await permission.request();
  }

  Future<void> loadWallpaper() async {
    if (!_hasPermission) {
      await _checkPermission();
      if (!_hasPermission) {
        setState(() {
          _error = 'Permission denied. Cannot load wallpaper.';
        });
        return;
      }
    }
    
    try {
      final bytes = await WallpaperPlugin.getWallpaper();
      setState(() {
        _wallpaper = bytes;
        _error = '';
      });
    } on PlatformException catch (e) {
      setState(() {
        _error = 'Failed to load wallpaper: ${e.message}';
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
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(_error),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        openAppSettings();
                      },
                      child: const Text('Open Settings'),
                    ),
                  ],
                )
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
