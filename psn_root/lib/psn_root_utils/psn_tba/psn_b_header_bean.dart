import 'package:psn_root/psn_root_utils/psn_root_export.dart';

class PsnBHeaderBean{
  Future<Map<String,dynamic>> getHeaderMap()async=>{
    "kimball" : await FlutterTbaInfo.instance.getSystemLanguage(),
    "alumina" : await FlutterTbaInfo.instance.getDeviceModel(),
    "hiroshi" : await FlutterTbaInfo.instance.getBundleId(),
  };
}