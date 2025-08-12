import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_dialog/psn_b_unlock_dialog/psn_b_unlock_dialog_con.dart';
import 'package:psn_b/psn_b_utils/pns_b_card_type_enum.dart';
import 'package:psn_b/psn_b_widget/psn_b_btn_widget.dart';
import 'package:psn_root/psn_root_page/psn_root_dialog.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_widget/psn_click.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';

class PsnBUnlockDialog extends PsnRootDialog<PsnBUnlockDialogCon>{
  PsnBCardTypeEnum typeEnum;
  PsnBUnlockDialog({required this.typeEnum});
  @override
  PsnBUnlockDialogCon onCon() => PsnBUnlockDialogCon();

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

  _btnWidget()=>PsnBBtnWidget(
    text: "Unlock",
    bgName: "btn_green",
    showVideoIcon: true,
    onTap: (){
      psnCon.clickUnlock(typeEnum);
    },
  );
}