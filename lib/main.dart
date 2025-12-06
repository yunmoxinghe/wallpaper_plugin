import 'dart:typed_data';
import 'package:flutter/material.dart';
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
  Uint8List? wallpaper;

  @override
  void initState() {
    super.initState();
    loadWallpaper();
  }

  Future<void> loadWallpaper() async {
    final bytes = await WallpaperPlugin.getWallpaper();
    setState(() {
      wallpaper = bytes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Wallpaper Plugin Test')),
        body: Center(
          child: wallpaper == null
              ? const Text('加载中...')
              : Image.memory(wallpaper!),
        ),
      ),
    );
  }
}
