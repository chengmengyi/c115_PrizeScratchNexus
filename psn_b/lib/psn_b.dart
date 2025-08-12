
import 'psn_b_platform_interface.dart';

class Psn_b {
  Future<String?> getPlatformVersion() {
    return Psn_bPlatform.instance.getPlatformVersion();
  }
}
