import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_dialog/psn_safe_check_dialog/psn_safe_check_dialog_con.dart';
import 'package:psn_b/psn_b_widget/psn_b_btn_widget.dart';
import 'package:psn_b/psn_b_widget/psn_multi_style_typewriter.dart';
import 'package:psn_root/psn_root_page/psn_root_dialog.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_widget/psn_click.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';
import 'package:psn_root/psn_root_widget/psn_text_widget.dart';

class PsnSafeCheckDialog extends PsnRootDialog<PsnSafeCheckDialogCon>{
  String account;
  SafeCheckType safeCheckType;
  Function() dismissCallback;

  PsnSafeCheckDialog({
    required this.account,
    required this.safeCheckType,
    required this.dismissCallback,
});
  @override
  PsnSafeCheckDialogCon onCon() => PsnSafeCheckDialogCon(safeCheckType);

  @override
  Widget onCreate() => Container(
    width: double.infinity,
    height: 484.h,
    margin: EdgeInsets.only(left: 29.w,right: 29.w,bottom: 41.h,),
    child: Stack(
      children: [
        PsnImageWidget(name: "cash_init1",width: double.infinity,height: double.infinity,),
        // Positioned(
        //   top: 15.h,
        //   right: 15.w,
        //   child: PsnClick(
        //     onTap: (){
        //       PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
        //     },
        //     child: PsnImageWidget(name: "icon_close2",width: 20.w,height: 20.w,),
        //   ),
        // ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 16.h),
            child: PsnTextWidget(text: "Security review in progress", size: 16.sp, color: "#FFFFFF".toColor(),),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 60.h,),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10.h),
                    child: PsnImageWidget(name: "safe2",width: 214.w,height: 143.h,),
                  ),
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        width: 120.w,
                        height: 21.h,
                        margin: EdgeInsets.only(top: 4.h),
                        decoration: BoxDecoration(
                          color: "#000000".toColor(),
                          borderRadius: BorderRadius.circular(11.w),
                        ),
                      ),
                      GetBuilder<PsnSafeCheckDialogCon>(
                        id: "pro_text",
                        builder: (_)=>PsnTextWidget(
                          text: "${psnCon.currentPro}%",
                          size: 24.sp,
                          color: "#FFFFFF".toColor(),
                          outlineColor: "#131730".toColor(),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 16.h,),
              MultiStyleTypewriter(
                speed: Duration(milliseconds: 80),
                onProgress: (pro){
                  psnCon.updatePro(pro);
                },
                lines: [
                  TextLine(
                    "Transaction time verification:",
                    TextStyle(fontSize: 15.sp, color: "#526171".toColor(),fontWeight: FontWeight.bold,),
                    0,
                  ),
                  TextLine(
                    getEnglishDateTime(),
                    TextStyle(fontSize: 15.sp, color: "#000000".toColor(),fontWeight: FontWeight.bold,),
                    1,
                  ),
                  TextLine(
                    "Device verification:",
                    TextStyle(fontSize: 15.sp, color: "#526171".toColor(),fontWeight: FontWeight.bold,height: 1.8),
                    2,
                  ),
                  TextLine(
                    "No abnormalities",
                    TextStyle(fontSize: 15.sp, color: "#000000".toColor(),fontWeight: FontWeight.bold,),
                    3,
                  ),
                  TextLine(
                    "Account verification:",
                    TextStyle(fontSize: 15.sp, color: "#526171".toColor(),fontWeight: FontWeight.bold,height: 1.8),
                    4,
                  ),
                  TextLine(
                    account,
                    TextStyle(fontSize: 15.sp, color: "#000000".toColor(),fontWeight: FontWeight.bold,),
                    5,
                  ),
                  TextLine(
                    "Account Risk Verification:",
                    TextStyle(fontSize: 15.sp, color: "#526171".toColor(),fontWeight: FontWeight.bold,height: 1.8),
                    6,
                  ),
                  TextLine(
                    safeCheckType==SafeCheckType.fail?"Requires Manual Verification":"Verification Approved",
                    TextStyle(fontSize: 15.sp, color: safeCheckType==SafeCheckType.fail?"#A200FF".toColor():"#148C46".toColor(),fontWeight: FontWeight.bold,),
                    7,
                  ),
                ],
              ),
              SizedBox(height: 16.h,),
              GetBuilder<PsnSafeCheckDialogCon>(
                id: "btn",
                builder: (_)=>Visibility(
                  visible: psnCon.showBtn,
                  child: PsnBBtnWidget(
                    text: "Verification",
                    bgName: "btn_green",
                    onTap: (){
                      psnCon.clickVer(dismissCallback);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}