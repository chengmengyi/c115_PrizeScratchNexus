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
    margin: EdgeInsets.only(left: 49.w,right: 49.w),
    decoration: BoxDecoration(
      color: "#FFFFFF".toColor(),
      borderRadius: BorderRadius.circular(15.w),
    ),
    child: Stack(
      alignment: Alignment.topCenter,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 17.h,),
            PsnTextWidget(text: "Don't Worry", size: 19.sp, color: "#000000".toColor(),),
            SizedBox(height: 7.h,),
            PsnImageWidget(name: "worry1",width: 120.w,height: 120.h,),
            Container(
              margin: EdgeInsets.only(left: 20.w,right: 20.w),
              child: PsnTextWidget(
                text: "We will assist you with completing your withdrawal—simply follow the steps below to finalize the process.",
                size: 15.sp,
                color: "#000000".toColor(),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20.h,),
            PsnClick(
              onTap: (){
                psnCon.clickGo(clickCallback);
              },
              child: Container(
                width: double.infinity,
                height: 47.h,
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 37.w,right: 37.w),
                decoration: BoxDecoration(
                  color: "#356ECA".toColor(),
                  borderRadius: BorderRadius.circular(12.w),
                ),
                child: PsnTextWidget(text: "Go", size: 16.sp, color: "#FFFFFF".toColor(),),
              ),
            ),
            SizedBox(height: 30.h,),
          ],
        ),
        Positioned(
          top: 10.h,
          right: 10.w,
          child: PsnClick(
            onTap: (){
              psnCon.clickGo(clickCallback);
            },
            child: PsnImageWidget(name: "icon_close3",width: 25.w,height: 25.w,),
          ),
        ),
      ],
    ),
  );
}