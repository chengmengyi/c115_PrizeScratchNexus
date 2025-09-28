import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_dialog/psn_dont_worry_dialog/psn_dont_worry_dialog_con.dart';
import 'package:psn_root/psn_root_page/psn_root_dialog.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_widget/psn_click.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';
import 'package:psn_root/psn_root_widget/psn_text_widget.dart';

class PsnDontWorryDialog extends PsnRootDialog<PsnDontWorryDialogCon>{
  Function() clickCallback;
  PsnDontWorryDialog({
    required this.clickCallback,
});

  @override
  PsnDontWorryDialogCon onCon() => PsnDontWorryDialogCon();

  @override
  Widget onCreate() => Container(
    width: double.infinity,
    margin: EdgeInsets.only(left: 98.w,right: 98.w),
    decoration: BoxDecoration(
      color: "#FFFFFF".toColor(),
      borderRadius: BorderRadius.circular(30.w),
    ),
    child: Stack(
      alignment: Alignment.topCenter,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 34.h,),
            PsnTextWidget(text: "Don't Worry", size: 38.sp, color: "#000000".toColor(),),
            SizedBox(height: 14.h,),
            PsnImageWidget(name: "worry1",width: 240.w,height: 240.h,),
            Container(
              margin: EdgeInsets.only(left: 40.w,right: 40.w),
              child: PsnTextWidget(
                text: "We will assist you with completing your withdrawal—simply follow the steps below to finalize the process.",
                size: 31.sp,
                color: "#000000".toColor(),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 40.h,),
            PsnClick(
              onTap: (){
                psnCon.clickGo(clickCallback);
              },
              child: Container(
                width: double.infinity,
                height: 95.h,
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 75.w,right: 75.w),
                decoration: BoxDecoration(
                  color: "#356ECA".toColor(),
                  borderRadius: BorderRadius.circular(25.w),
                ),
                child: PsnTextWidget(text: "Go", size: 33.sp, color: "#FFFFFF".toColor(),),
              ),
            ),
            SizedBox(height: 60.h,),
          ],
        ),
        Positioned(
          top: 20.h,
          right: 20.w,
          child: PsnClick(
            onTap: (){
              psnCon.clickGo(clickCallback);
            },
            child: PsnImageWidget(name: "icon_close3",width: 50.w,height: 50.w,),
          ),
        ),
      ],
    ),
  );
}