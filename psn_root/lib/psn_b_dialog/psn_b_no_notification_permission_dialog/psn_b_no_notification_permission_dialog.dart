import 'package:flutter/material.dart';
import 'package:psn_root/psn_b_dialog/psn_b_no_notification_permission_dialog/psn_b_no_notification_permission_dialog_con.dart';
import 'package:psn_root/psn_root_page/psn_root_dialog.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_widget/psn_click.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';
import 'package:psn_root/psn_root_widget/psn_text_widget.dart';

class PsnBNoNotificationPermissionDialog extends PsnRootDialog<PsnBNoNotificationPermissionDialogCon>{
  @override
  PsnBNoNotificationPermissionDialogCon onCon() => PsnBNoNotificationPermissionDialogCon();


  @override
  Widget onCreate() => Container(
    width: double.infinity,
    height: 710.h,
    margin: EdgeInsets.only(left: 58.w,right: 58.w),
    child: Stack(
      children: [
        PsnImageWidget(name: "no_per1",width: double.infinity,height: double.infinity,),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 32.h),
            child: PsnTextWidget(text: "Cash Reward Reminder", size: 38.sp, color: "#FFFFFF".toColor(),),
          ),
        ),
        Positioned(
          top: 29.h,
          right: 29.w,
          child: PsnClick(
            onTap: (){
              psnCon.clickClose();
            },
            child: PsnImageWidget(name: "icon_close2",width: 40.w,height: 40.w,),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PsnImageWidget(name: "no_per2",height: 226.h,boxFit: BoxFit.fitHeight,),
              SizedBox(height: 30.h,),
              Container(
                margin: EdgeInsets.only(left: 35.w,right: 35.w),
                child: PsnTextWidget(text: "You've watched all  available ads for today.Try again tomorrow.", size: 34.sp, color: "#535F75".toColor(),),
              ),
              SizedBox(height: 56.h,),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PsnClick(
                    onTap: (){
                      psnCon.clickClose();
                    },
                    child: PsnTextWidget(text: "Cancel", size: 36.sp, color: "#2F5E85".toColor(),fontWeight: FontWeight.bold,),
                  ),
                  SizedBox(width: 40.w,),
                  PsnClick(
                    onTap: (){
                      psnCon.clickTo();
                    },
                    child: SizedBox(
                      width: 297.w,
                      height: 107.h,
                      child: Stack(
                        children: [
                          PsnImageWidget(name: "btn_blue",width: double.infinity,height: double.infinity,),
                          Align(
                            alignment: Alignment.center,
                            child: PsnTextWidget(text: "Receive", size: 42.sp, color: "#F2F3F3".toColor(),outlineColor: "#090733".toColor(),),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40.h,),
            ],
          ),
        ),
      ],
    ),
  );
}