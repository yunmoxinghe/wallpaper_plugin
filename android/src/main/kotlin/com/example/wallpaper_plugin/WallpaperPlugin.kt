package com.example.wallpaper_plugin

import android.app.WallpaperManager
import android.content.Context
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.drawable.BitmapDrawable
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.ByteArrayOutputStream

class WallpaperPlugin : FlutterPlugin, MethodChannel.MethodCallHandler {

    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        context = binding.applicationContext
        channel = MethodChannel(binding.binaryMessenger, "wallpaper_plugin")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "getWallpaper" -> {
                val bytes = getWallpaperBytes()
                result.success(bytes)
            }
            else -> result.notImplemented()
        }
    }

    // --------------------------------------
    //       核心方法：获取壁纸（静态 + 动态缩略图）
    // --------------------------------------
    private fun getWallpaperBytes(): ByteArray? {
        val wm = WallpaperManager.getInstance(context)

        // 检查是否是动态壁纸
        val info = wm.wallpaperInfo
        if (info != null) {
            val liveThumb = getLiveWallpaperThumbnail(info.packageName, info.thumbnailResource)
            if (liveThumb != null) {
                return bitmapToBytes(liveThumb)
            }
            // 若动态壁纸没提供缩略图，则继续尝试 drawable（通常为纯色）
        }

        // 静态壁纸 or fallback
        val drawable = wm.drawable
        if (drawable is BitmapDrawable) {
            return bitmapToBytes(drawable.bitmap)
        }

        return null
    }

    // --------------------------------------
    //         获取动态壁纸缩略图
    // --------------------------------------
    private fun getLiveWallpaperThumbnail(packageName: String, resId: Int): Bitmap? {
        if (resId == 0) return null
        return try {
            val pm = context.packageManager
            val res = pm.getResourcesForApplication(packageName)
            BitmapFactory.decodeResource(res, resId)
        } catch (_: Exception) {
            null
        }
    }

    // --------------------------------------
    //         Bitmap → ByteArray
    // --------------------------------------
    private fun bitmapToBytes(bitmap: Bitmap): ByteArray {
        val stream = ByteArrayOutputStream()
        bitmap.compress(Bitmap.CompressFormat.PNG, 100, stream)
        return stream.toByteArray()
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
