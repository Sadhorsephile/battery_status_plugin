package com.example.battery_status_plugin

import android.content.*
import android.app.Activity
import android.content.Context
import androidx.annotation.NonNull
import android.os.BatteryManager
import android.os.Bundle
import android.content.Intent
import android.content.IntentFilter

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result


class BatteryStatusPlugin: FlutterPlugin, MethodCallHandler {
  
  private lateinit var channel : MethodChannel
  private lateinit var batteryManager: BatteryManager
  // Контекст нужен для подписки/отписки на интент изменения заряда батареи.
  private lateinit var context: Context



  // Обработчик получения заряда батареи.
  protected val onBatteryChangedReceiver: BroadcastReceiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context, intent: Intent) {
            val batLevel:Int = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
            // Каждый раз, когда меняется заряд батареи, вызываем метод batteryLvlChanged к Дарту.
            channel.invokeMethod("batteryLvlChanged", batLevel)
        }
    }

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "battery_status_plugin")
    channel.setMethodCallHandler(this)
    // Забираем контекст
    context = flutterPluginBinding.applicationContext
    // И менеджер батареи
    batteryManager = context.getSystemService(Context.BATTERY_SERVICE) as BatteryManager
    
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "init" -> {
        // Подписываем на события батареи наш обработчик.
        context.registerReceiver(onBatteryChangedReceiver, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
      }
      "getPlatformVersion" -> {
        result.success("Android ${android.os.Build.VERSION.RELEASE}")
      }
      "getCurrentBatteryLevel" -> {
        // Получаем текущий уровень батареи.
        val batLevel:Int = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        result.success(batLevel)
      }
      "dispose" -> {
        // Отписываем от событий батареи наш обработчик.
        context.unregisterReceiver(onBatteryChangedReceiver)
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    context.unregisterReceiver(onBatteryChangedReceiver)
    channel.setMethodCallHandler(null)
  }
}
