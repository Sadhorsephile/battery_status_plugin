import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'battery_status_plugin_method_channel.dart';

abstract class BatteryStatusPluginPlatform extends PlatformInterface {
  /// Constructs a BatteryStatusPluginPlatform.
  BatteryStatusPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static BatteryStatusPluginPlatform _instance = MethodChannelBatteryStatusPlugin();

  /// The default instance of [BatteryStatusPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelBatteryStatusPlugin].
  static BatteryStatusPluginPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [BatteryStatusPluginPlatform] when
  /// they register themselves.
  static set instance(BatteryStatusPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
