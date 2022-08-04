import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'battery_status_plugin_platform_interface.dart';

/// An implementation of [BatteryStatusPluginPlatform] that uses method channels.
class MethodChannelBatteryStatusPlugin extends BatteryStatusPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('battery_status_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
