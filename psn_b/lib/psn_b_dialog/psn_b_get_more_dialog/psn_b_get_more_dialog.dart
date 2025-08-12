import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_dialog/psn_b_get_more_dialog/psn_b_get_more_dialog_con.dart';
import 'package:psn_b/psn_b_utils/pns_b_card_type_enum.dart';
import 'package:psn_b/psn_b_widget/psn_b_btn_widget.dart';
import 'package:psn_root/psn_root_page/psn_root_dialog.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_widget/psn_click.dart';
import 'package:psn_root/psn_root_widget/psn_gradient_text.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';

class PsnBGetMoreDialog extends PsnRootDialog<PsnBGetMoreDialogCon>{
  PsnBCardTypeEnum cardTypeEnum;
  Function()? clickClose;
  PsnBGetMoreDialog({
    required this.cardTypeEnum,
    this.clickClose,
  });

  @override
  PsnBGetMoreDialogCon onCon() => PsnBGetMoreDialogCon();

  @override
  Widget onCreate() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      _titleWidget(),
      _coinsWidget(),
      SizedBox(height: 90.h,),
      _btnWidget(),
    ],
  );

  _titleWidget()=>Container(
    width: double.infinity,
    margin: EdgeInsets.only(left: 30.w,right: 30.w),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        PsnClick(
          onTap: (){
            psnCon.clickClose(clickClose);
          },
          child: PsnImageWidget(name: "icon_close",width: 71.w,height: 71.w,),
        ),
        SizedBox(height: 42.h,),
        Stack(
          alignment: Alignment.center,
          children: [
            PsnImageWidget(name: "win1",width: double.infinity,height: 128.h,),
            PsnImageWidget(name: "fail1",height: 60.h,boxFit: BoxFit.fitHeight,),
          ],
        ),
      ],
    ),
  );

  _coinsWidget()=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Stack(
        alignment: Alignment.center,
        children: [
          PsnImageWidget(name: "win3",width: double.infinity,height: 500.h,),
          PsnImageWidget(name: "fail2",width: 380.w,height: 358.h,),
        ],
      ),
      PsnGradientText(
        data: "+5",
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: ["#FFFED5".toColor(),"#FDFC07".toColor(),],
        ),
        size: 60.sp,
        outlineColor: "#FFD52C".toColor(),
      )
    ],
  );

  _btnWidget()=>PsnBBtnWidget(
    text: "5000",
    bgName: "btn_blue",
    leftIcon: PsnImageWidget(name: "icon_coins",width: 40.w,height: 40.w,),
    onTap: (){
      psnCon.clickAdd(cardTypeEnum);
    },
  );
}