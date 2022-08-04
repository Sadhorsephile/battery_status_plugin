import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'battery_status_plugin_platform_interface.dart';

/// An implementation of [BatteryStatusPluginPlatform] that uses method channels.
class MethodChannelBatteryStatusPlugin extends BatteryStatusPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('battery_status_plugin');

  final _batteryLvlController = StreamController<int>();

  MethodChannelBatteryStatusPlugin() {
    methodChannel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'batteryLvlChanged':
          _batteryLvlController.add(call.arguments as int);
          break;
        default:
          throw UnimplementedError('Unimplemented method: ${call.method}');
      }
    });
  }

  @override
  Stream<int> get batteryLvl => _batteryLvlController.stream;

  @override
  Future<void> init() async {
    await methodChannel.invokeMethod('init');
  }

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<int?> getCurrentBatteryLevel() async {
    final level = await methodChannel.invokeMethod<int>('getCurrentBatteryLevel');
    return level;
  }

  @override
  void dispose() {
    _batteryLvlController.close();
    methodChannel.invokeMethod<void>('dispose');
  }
}
