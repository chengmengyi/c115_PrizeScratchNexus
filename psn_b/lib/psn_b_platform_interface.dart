import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'psn_b_method_channel.dart';

abstract class Psn_bPlatform extends PlatformInterface {
  /// Constructs a Psn_bPlatform.
  Psn_bPlatform() : super(token: _token);

  static final Object _token = Object();

  static Psn_bPlatform _instance = MethodChannelPsn_b();

  /// The default instance of [Psn_bPlatform] to use.
  ///
  /// Defaults to [MethodChannelPsn_b].
  static Psn_bPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [Psn_bPlatform] when
  /// they register themselves.
  static set instance(Psn_bPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
