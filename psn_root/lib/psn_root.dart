
import 'psn_root_platform_interface.dart';

class PsnRoot {
  static final PsnRoot _psnRoot=PsnRoot();
  static PsnRoot get instance => _psnRoot;

  openPsnH() {
    return PsnRootPlatform.instance.openPsnH();
  }
}
