import 'package:psn_root/psn_root_page/psn_root_con.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';

class PsnWebCon extends PsnRootCon{
  var title="",url="";
  late WebViewController webViewController;

  @override
  void onInit() {
    super.onInit();
    var map = PsnRootRouters.instance.getPrams();
    title=map["title"];
    url=map["url"];
    webViewController=WebViewController();
    webViewController.setJavaScriptMode(JavaScriptMode.unrestricted);
    webViewController.loadRequest(Uri.parse(url));
  }
}