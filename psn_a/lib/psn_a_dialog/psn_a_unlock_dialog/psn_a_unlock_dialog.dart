import 'package:flutter/material.dart';
import 'package:psn_a/psn_a_dialog/psn_a_unlock_dialog/psn_a_unlock_dialog_con.dart';
import 'package:psn_a/psn_a_utils/pns_a_card_type_enum.dart';
import 'package:psn_a/psn_a_widget/psn_a_btn_widget.dart';
import 'package:psn_root/psn_root_page/psn_root_dialog.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_widget/psn_click.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';

class PsnAUnlockDialog extends PsnRootDialog<PsnAUnlockDialogCon>{
  PsnACardTypeEnum typeEnum;
  PsnAUnlockDialog({required this.typeEnum});
  @override
  PsnAUnlockDialogCon onCon() => PsnAUnlockDialogCon();

  @override
  Widget onCreate() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      _titleWidget(),
      _lockWidget(),
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
            psnCon.clickClose();
          },
          child: PsnImageWidget(name: "icon_close",width: 71.w,height: 71.w,),
        ),
        SizedBox(height: 42.h,),
        Stack(
          alignment: Alignment.center,
          children: [
            PsnImageWidget(name: "win1",width: double.infinity,height: 128.h,),
            PsnImageWidget(name: "unlock1",height: 48.h,boxFit: BoxFit.fitHeight,),
          ],
        ),
      ],
    ),
  );

  _lockWidget()=>Stack(
    alignment: Alignment.center,
    children: [
      PsnImageWidget(name: "win3",width: double.infinity,height: 500.h,),
      PsnImageWidget(name: "unlock2",width: 190.w,height: 238.h,),
    ],
  );

  _btnWidget()=>PsnABtnWidget(
    text: "30000",
    bgName: "btn_blue",
    leftIcon: PsnImageWidget(name: "icon_coins",width: 40.w,height: 40.w,),
    onTap: (){
      psnCon.clickUnlock(typeEnum);
    },
  );
}