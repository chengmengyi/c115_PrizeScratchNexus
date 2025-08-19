import 'package:psn_root/psn_root_page/psn_root_con.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';
import 'package:psn_root/psn_root_utils/psn_local_info.dart';
import 'package:psn_root/psn_root_utils/psn_music_utils.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';

class PsnBSetDialogCon extends PsnRootCon{
  toWeb(){
    PsnRootRouters.instance.router(
      routersEnum: PsnRoutersEnum.toNamed,
      content: "/root/web",
      params: {"url": PsnLocalInfo.privacy,"title":"Privacy Policy"},
    );
  }

  toEmail(){
    FlutterTbaInfo.instance.jumpToEmail(PsnLocalInfo.email);
  }

  clickBackMusic(){
    PsnMusicUtils.instance.clickBackBtn();
    update(["back"]);
  }

  clickVoiceBtn(){
    PsnMusicUtils.instance.clickVoiceBtn();
    update(["voice"]);
  }
}