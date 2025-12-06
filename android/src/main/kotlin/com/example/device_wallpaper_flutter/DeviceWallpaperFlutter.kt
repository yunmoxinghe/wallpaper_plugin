package com.example.device_wallpaper_flutter

import android.app.WallpaperManager
import android.content.Context
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.Drawable
import android.os.Build
import androidx.annotation.RequiresApi
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.ByteArrayOutputStream

class DeviceWallpaperFlutter : FlutterPlugin, MethodChannel.MethodCallHandler {

    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        context = binding.applicationContext
        channel = MethodChannel(binding.binaryMessenger, "device_wallpaper_flutter")
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
            // 对于动态壁纸，我们尝试获取缩略图
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O_MR1) {
                val liveThumb = getLiveWallpaperThumbnail(wm)
                if (liveThumb != null) {
                    return bitmapToBytes(liveThumb)
                }
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
    //         获取动态壁纸缩略图 (API 27+)
    // --------------------------------------
    @RequiresApi(Build.VERSION_CODES.O_MR1)
    private fun getLiveWallpaperThumbnail(wm: WallpaperManager): Bitmap? {
        return try {
            val drawable = wm.getBuiltInDrawable()
            if (drawable != null) {
                drawableToBitmap(drawable)
            } else {
                null
            }
        } catch (_: Exception) {
            null
        }
    }

    // --------------------------------------
    //         Drawable → Bitmap
    // --------------------------------------
    private fun drawableToBitmap(drawable: Drawable): Bitmap {
        if (drawable is BitmapDrawable) {
            return drawable.bitmap
        }

        val bitmap = Bitmap.createBitmap(
            drawable.intrinsicWidth,
            drawable.intrinsicHeight,
            Bitmap.Config.ARGB_8888
        )

        val canvas = Canvas(bitmap)
        drawable.setBounds(0, 0, canvas.width, canvas.height)
        drawable.draw(canvas)

        return bitmap
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