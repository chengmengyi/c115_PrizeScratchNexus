import 'package:psn_root/psn_root_utils/psn_root_export.dart';

class PsnBQueryBean{
  Future<String> getQueryStr()async{
    var bundleId = await FlutterTbaInfo.instance.getBundleId();
    var brand = await FlutterTbaInfo.instance.getBrand();
    var deviceModel = await FlutterTbaInfo.instance.getDeviceModel();
    var timer = DateTime.now().millisecondsSinceEpoch;
    return "?hiroshi=$bundleId&wing=$brand&alumina=$deviceModel&coconut=$timer";
  }
}