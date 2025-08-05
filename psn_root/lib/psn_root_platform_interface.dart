import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'psn_root_method_channel.dart';

abstract class PsnRootPlatform extends PlatformInterface {
  /// Constructs a PsnRootPlatform.
  PsnRootPlatform() : super(token: _token);

  static final Object _token = Object();

  static PsnRootPlatform _instance = MethodChannelPsnRoot();

  /// The default instance of [PsnRootPlatform] to use.
  ///
  /// Defaults to [MethodChannelPsnRoot].
  static PsnRootPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PsnRootPlatform] when
  /// they register themselves.
  static set instance(PsnRootPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
