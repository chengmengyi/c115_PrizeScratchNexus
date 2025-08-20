import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'psn_root_platform_interface.dart';

/// An implementation of [PsnRootPlatform] that uses method channels.
class MethodChannelPsnRoot extends PsnRootPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('psn_root');

  @override
  Future<void> openPsnH() async {
    await methodChannel.invokeMethod<String>('openPsnH');
  }
}
