import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
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

  @override
  void initState() {
    super.initState();
    loadWallpaper();
  }

  Future<void> loadWallpaper() async {
    try {
      final bytes = await WallpaperPlugin.getWallpaper();
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
