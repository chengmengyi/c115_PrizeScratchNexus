import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_bean/psn_b_card_bean.dart';
import 'package:psn_b/psn_b_utils/pns_b_card_type_enum.dart';
import 'package:psn_b/psn_b_utils/psn_b_event_code.dart';
import 'package:psn_b/psn_b_utils/psn_b_utils.dart';
import 'package:psn_root/psn_root_page/psn_root_statefull.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_widget/psn_spine_widget.dart';
import 'package:psn_root/psn_root_widget/psn_text_widget.dart';
import 'package:spine_flutter/spine_flutter.dart';


class PsnCardLockWidget extends PsnRootStateful{
  PsnBCardBean cardBean;
  PsnCardLockWidget({
    required this.cardBean,
});
  @override
  State<StatefulWidget> createState() => _PsnCardLockWidgetState();
}

class _PsnCardLockWidgetState extends PsnRootStatefulState<PsnCardLockWidget>{
  late SpineWidgetController controller;

  @override
  void initState() {
    super.initState();
    controller=SpineWidgetController(
      onInitialized: (controller) {
        // controller.animationState.setAnimationByName(0, "animation", false);
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    if(widget.cardBean.unlock!=1){
      return Container();
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // PsnImageWidget(name: "icon_lock",width: 53.w,height: 68.h,),
        PsnSpineWidget(
          atlasFile: "suo",
          skeletonFile: "skeleton",
          animatorName: "animation",
          folder: "jiesuo",
          width: 53.w,
          height: 68.w,
          controller: controller,
        ),
        SizedBox(height: 10.h,),
        PsnTextWidget(
          text: "Unlock thid game mode at",
          size: 12.sp,
          color: "#FFFFFF".toColor(),
          outlineColor: "#000000".toColor(),
        ),
        SizedBox(height: 10.h,),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            PsnTextWidget(
              text: "Level",
              size: 12.sp,
              color: "#FFFFFF".toColor(),
              outlineColor: "#000000".toColor(),
            ),
            PsnTextWidget(
              text: " ${getLevelByCardType(PsnBCardTypeEnum.values.byName(widget.cardBean.cardType??""))}",
              size: 12.sp,
              color: "#FFE400".toColor(),
              outlineColor: "#000000".toColor(),
            ),
          ],
        )
      ],
    );
  }

  @override
  bool initEvent() => true;

  @override
  receivedEventBus(int code, int? intValue, String? strValue, anyValue) {
    switch(code){
      case PsnBEventCode.showLockAnimator:
        showLockAnimator(anyValue);
        break;
    }
  }

  showLockAnimator(anyValue){
    if(widget.cardBean.cardType!=anyValue){
      return;
    }
    controller.animationState.setAnimationByName(0, "animation", false);
  }
}