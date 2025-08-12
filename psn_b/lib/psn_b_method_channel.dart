import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'psn_b_platform_interface.dart';

/// An implementation of [Psn_bPlatform] that uses method channels.
class MethodChannelPsn_b extends Psn_bPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('psn_b');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
