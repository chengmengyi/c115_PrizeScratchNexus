import 'package:flutter/material.dart';
import 'package:psn_a/psn_a_dialog/psn_a_fail_dialog/psn_a_fail_dialog_con.dart';
import 'package:psn_a/psn_a_widget/psn_a_btn_widget.dart';
import 'package:psn_root/psn_root_page/psn_root_dialog.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';

class PsnAFailDialog extends PsnRootDialog<PsnAFailDialogCon>{
  Function() dismissCallback;
  PsnAFailDialog({
    required this.dismissCallback,
});

  @override
  PsnAFailDialogCon onCon() => PsnAFailDialogCon();

  @override
  Widget onCreate() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      PsnImageWidget(name: "fail3",height: 169.h,boxFit: BoxFit.fitHeight,),
      SizedBox(height: 57.h,),
      PsnImageWidget(name: "fail4",width: 313.w,height: 313.w,),
      SizedBox(height: 90.h,),
      PsnABtnWidget(
        text: "Continue",
        bgName: "btn_blue",
        onTap: (){
          psnCon.clickContinue(dismissCallback);
        },
      ),
    ],
  );
}