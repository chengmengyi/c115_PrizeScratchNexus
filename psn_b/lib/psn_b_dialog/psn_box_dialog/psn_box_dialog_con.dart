import 'package:psn_b/psn_b_bean/psn_b_box_bean.dart';
import 'package:psn_b/psn_b_dialog/psn_b_get_money_dialog/psn_b_get_money_dialog.dart';
import 'package:psn_b/psn_b_utils/psn_b_user_info_utils.dart';
import 'package:psn_b/psn_b_utils/psn_b_value_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_con.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';
import 'package:psn_root/psn_root_utils/psn_ad_event_enum.dart';
import 'package:psn_root/psn_root_utils/psn_ad_utils.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_utils/psn_tba/psn_b_tba_utils.dart';
import 'package:psn_root/psn_root_utils/psn_tba_point_enum.dart';
import 'package:spine_flutter/spine_flutter.dart';

class PsnBoxDialogCon extends PsnRootCon{
  var canClick=true,showGetAllBtn=false,itemCanClick=true;
  List<PsnBBoxBean> boxList=[
    PsnBBoxBean(
      reward: PsnBValueUtils.instance.getBoxReward(),
      open: false,
      controller: SpineWidgetController(),
    ),
    PsnBBoxBean(
      reward: PsnBValueUtils.instance.getBoxReward(),
      open: false,
      controller: SpineWidgetController(),
    ),
    PsnBBoxBean(
      reward: PsnBValueUtils.instance.getBoxReward(),
      open: false,
      controller: SpineWidgetController(),
    ),
  ];

  clickBox(PsnBBoxBean bean){
    if(bean.open||!canClick||!itemCanClick){
      return;
    }
    itemCanClick=false;
    PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.treasure_c);
    canClick=false;
    bean.controller.animationState.setListener((type, trackEntry, event) {
      if (type == EventType.complete) {
        bean.open=true;
        update(["box"]);
        _showGetDialog(bean);
      }
    });
    bean.controller.animationState.setAnimationByName(0, "animation", false);
  }

  _showGetDialog(PsnBBoxBean bean)async{
    await Future.delayed(Duration(milliseconds: 1500));
    canClick=true;
    PsnRootRouters.instance.router(
      routersEnum: PsnRoutersEnum.dialog,
      content: PsnBGetMoneyDialog(
        reward: bean.reward,
        adEventEnumDouble: PsnAdEventEnum.apwxi_boxgetpop_rv,
        adEventEnumClose: PsnAdEventEnum.apwxi_boxgetpop_int,
        dismissCallback: (){
          showGetAllBtn=true;
          update(["btn"]);
        },
      ),
    );
  }

  clickGetAll(Function() dismissCallback){
    if(!canClick){
      return;
    }
    PsnBTbaUtils.instance.pointEvent(pointEnum: PsnTbaPointEnum.treasure_reward_c);
    PsnAdUtils.instance.showAdBBBBBB(
      adType: AdType.reward,
      evnetEnum: PsnAdEventEnum.apwxi_box_rv,
      showAd: PsnBValueUtils.instance.showAd(AdType.reward),
      closeCallback: (){
        canClick=false;
        var allReward = boxList.where((e) => e.open == false).fold(0.0, (prev, e) => twoNumAdd(prev, e));
        var indexWhere = boxList.indexWhere((value)=>!value.open);
        if(indexWhere>=0){
          boxList[indexWhere].controller.animationState.setListener((type, trackEntry, event) {
            if (type == EventType.complete) {
              _clickAllResult(allReward,dismissCallback);
            }
          });
        }
        for (var value in boxList) {
          if(value.open){
            continue;
          }
          value.controller.animationState.setAnimationByName(0, "animation", false);
        }
      },
    );
  }

  _clickAllResult(double allReward, Function() dismissCallback)async{
    for (var value in boxList) {
      value.open=true;
    }
    update(["box"]);
    await Future.delayed(Duration(milliseconds: 1500));
    canClick=true;
    PsnBUserInfoUtils.instance.updateUserCoins(allReward);
    PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
    dismissCallback.call();
  }

  clickClose(Function() dismissCallback){
    if(!canClick){
      return;
    }
    PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
    dismissCallback.call();
  }
}