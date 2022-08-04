
import 'battery_status_plugin_platform_interface.dart';

class BatteryStatusPlugin {
  Future<String?> getPlatformVersion() {
    return BatteryStatusPluginPlatform.instance.getPlatformVersion();
  }
}
