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
    height: 355.h,
    margin: EdgeInsets.only(left: 29.w,right: 29.w),
    child: Stack(
      children: [
        PsnImageWidget(name: "no_per1",width: double.infinity,height: double.infinity,),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 16.h),
            child: PsnTextWidget(text: "Cash Reward Reminder", size: 19.sp, color: "#FFFFFF".toColor(),),
          ),
        ),
        Positioned(
          top: 15.h,
          right: 15.w,
          child: PsnClick(
            onTap: (){
              psnCon.clickClose();
            },
            child: PsnImageWidget(name: "icon_close2",width: 20.w,height: 20.w,),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 208.w,
                height: 133.h,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      bottom: 19.h,
                      child: PsnImageWidget(name: "no_per3",width: 86.w,height: 60.h,),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: PsnImageWidget(name: "no_per4",width: 86.w,height: 60.h,),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: PsnImageWidget(name: "no_per2",width: 111.w,height: 111.h,),
                    ),
                    Positioned(
                      top: 13.h,
                      right: 30.w,
                      child: Container(
                        width: 40.w,
                        height: 40.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.w),
                          color: "#FFFFFF".toColor(),
                        ),
                        child: Container(
                          width: 31.w,
                          height: 31.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: "#FF4747".toColor(),
                            borderRadius: BorderRadius.circular(15.w),
                          ),
                          child: PsnTextWidget(text: "1", size: 24.sp, color: "#FFFFFF".toColor(),),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.h,),
              Container(
                margin: EdgeInsets.only(left: 17.w,right: 17.w),
                child: PsnTextWidget(text: "Enable permissions for instant cash alerts – huge rewards waiting! Act now!", size: 17.sp, color: "#535F75".toColor(),),
              ),
              SizedBox(height: 28.h,),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PsnClick(
                    onTap: (){
                      psnCon.clickClose();
                    },
                    child: PsnTextWidget(text: "Cancel", size: 19.sp, color: "#2F5E85".toColor(),fontWeight: FontWeight.bold,),
                  ),
                  SizedBox(width: 20.w,),
                  PsnClick(
                    onTap: (){
                      psnCon.clickTo();
                    },
                    child: SizedBox(
                      width: 148.w,
                      height: 53.h,
                      child: Stack(
                        children: [
                          PsnImageWidget(name: "btn_blue",width: double.infinity,height: double.infinity,),
                          Align(
                            alignment: Alignment.center,
                            child: PsnTextWidget(text: "Receive", size: 4221.sp, color: "#F2F3F3".toColor(),outlineColor: "#090733".toColor(),),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h,),
            ],
          ),
        ),
      ],
    ),
  );
}