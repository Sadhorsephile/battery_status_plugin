import 'package:flutter_test/flutter_test.dart';
import 'package:battery_status_plugin/battery_status_plugin.dart';
import 'package:battery_status_plugin/battery_status_plugin_platform_interface.dart';
import 'package:battery_status_plugin/battery_status_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockBatteryStatusPluginPlatform 
    with MockPlatformInterfaceMixin
    implements BatteryStatusPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final BatteryStatusPluginPlatform initialPlatform = BatteryStatusPluginPlatform.instance;

  test('$MethodChannelBatteryStatusPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelBatteryStatusPlugin>());
  });

  test('getPlatformVersion', () async {
    BatteryStatusPlugin batteryStatusPlugin = BatteryStatusPlugin();
    MockBatteryStatusPluginPlatform fakePlatform = MockBatteryStatusPluginPlatform();
    BatteryStatusPluginPlatform.instance = fakePlatform;
  
    expect(await batteryStatusPlugin.getPlatformVersion(), '42');
  });
}
