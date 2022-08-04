import 'dart:async';

import 'battery_status_plugin_platform_interface.dart';

class BatteryStatusPlugin {
  Stream<int> get batteryLvl => BatteryStatusPluginPlatform.instance.batteryLvl;

  Future<void> init() {
    return BatteryStatusPluginPlatform.instance.init();
  }

  Future<String?> getPlatformVersion() {
    return BatteryStatusPluginPlatform.instance.getPlatformVersion();
  }

  Future<int?> getCurrentBatteryLevel() {
    return BatteryStatusPluginPlatform.instance.getCurrentBatteryLevel();
  }

  void dispose() {
    BatteryStatusPluginPlatform.instance.dispose();
  }
}
