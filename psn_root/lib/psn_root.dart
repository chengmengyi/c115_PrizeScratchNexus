
import 'psn_root_platform_interface.dart';

class PsnRoot {
  Future<String?> getPlatformVersion() {
    return PsnRootPlatform.instance.getPlatformVersion();
  }
}
