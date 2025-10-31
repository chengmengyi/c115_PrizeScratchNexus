import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_dialog/psn_b_set_dialog/psn_b_set_dialog_con.dart';
import 'package:psn_b/psn_b_storage/psn_b_storage.dart';
import 'package:psn_root/psn_root_page/psn_root_dialog.dart';
import 'package:psn_root/psn_root_routers/psn_root_routers.dart';
import 'package:psn_root/psn_root_routers/psn_routers_enum.dart';
import 'package:psn_root/psn_root_utils/psn_music_utils.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_widget/psn_click.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';
import 'package:psn_root/psn_root_widget/psn_text_widget.dart';

class PsnBSetDialog extends PsnRootDialog<PsnBSetDialogCon>{
  @override
  PsnBSetDialogCon onCon() => PsnBSetDialogCon();

  @override
  Widget onCreate() => Container(
    width: double.infinity,
    height: 289.h,
    margin: EdgeInsets.only(left: 20.w,right: 20.w),
    child: Stack(
      children: [
        PsnImageWidget(name: "set1",width: double.infinity,height: double.infinity,),
        Positioned(
          right: 0,
          child: PsnClick(
            onTap: (){
              PsnRootRouters.instance.router(routersEnum: PsnRoutersEnum.back, content: null);
            },
            child: PsnImageWidget(name: "icon_close",width: 32.w,height: 32.w,),
          ),
        ),
        Align(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PsnTextWidget(text: "SETTING", size: 24.sp, color: "#FFFFFF".toColor(),outlineColor: "#76D0FF".toColor(),),
              SizedBox(height: 20.h,),
              _bgMusicWidget(),
              SizedBox(height: 20.h,),
              _voiceMusicWidget(),
              SizedBox(height: 15.h,),
              _contactWidget(),
              SizedBox(height: 15.h,),
              _privacyWidget(),
            ],
          ),
        )
      ],
    ),
  );

  _bgMusicWidget()=>Row(
    children: [
      SizedBox(width: 38.w,),
      PsnImageWidget(name: "set2",width: 26.w,height: 29.h,),
      SizedBox(width: 25.w,),
      Expanded(
        child: PsnTextWidget(text: "Background Music", size: 14.sp, color: "#F1EBFF".toColor(),outlineColor: "#101C76".toColor(),),
      ),
      PsnClick(
        onTap: (){
          psnCon.clickBackMusic();
        },
        child: GetBuilder<PsnBSetDialogCon>(
          id: "back",
          builder: (_)=>PsnImageWidget(name: bBackMusicSwitch.getData()?"icon_on":"icon_off",width: 62.w,height: 22.h,),
        ),
      ),
      SizedBox(width: 30.w,),
    ],
  );

  _voiceMusicWidget()=>Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(width: 38.w,),
      PsnImageWidget(name: "set3",width: 26.w,height: 23.h,),
      SizedBox(width: 25.w,),
      Expanded(
        child: PsnTextWidget(text: "Sound Effects", size: 14.sp, color: "#F1EBFF".toColor(),outlineColor: "#101C76".toColor(),),
      ),
      PsnClick(
        onTap: (){
          psnCon.clickVoiceBtn();
        },
        child: GetBuilder<PsnBSetDialogCon>(
          id: "voice",
          builder: (_)=>PsnImageWidget(name: bVoiceMusicSwitch.getData()?"icon_on":"icon_off",width: 62.w,height: 22.h,),
        ),
      ),
      SizedBox(width: 30.w,),
    ],
  );

  _contactWidget()=>PsnClick(
    onTap: (){
      psnCon.toEmail();
    },
    child: Container(
      width: double.infinity,
      height: 46.h,
      margin: EdgeInsets.only(left: 25.w,right: 25.w),
      child: Stack(
        alignment: Alignment.center,
        children: [
          PsnImageWidget(name: "set4",width: double.infinity,height: double.infinity,),
          PsnTextWidget(
            text: "Contact Us",
            size: 21.sp,
            color: "#F0E9FF".toColor(),
            outlineColor: "#1543A1".toColor(),
            textDecoration: TextDecoration.underline,
            decorationColor: "#F0E9FF".toColor(),
          )
        ],
      ),
    ),
  );

  _privacyWidget()=>PsnClick(
    onTap: (){
      psnCon.toWeb();
    },
    child: Container(
      width: double.infinity,
      height: 46.h,
      margin: EdgeInsets.only(left: 25.w,right: 25.w),
      child: Stack(
        alignment: Alignment.center,
        children: [
          PsnImageWidget(name: "set4",width: double.infinity,height: double.infinity,),
          PsnTextWidget(
            text: "Privacy Poilcy",
            size: 21.sp,
            color: "#F0E9FF".toColor(),
            outlineColor: "#1543A1".toColor(),
            textDecoration: TextDecoration.underline,
            decorationColor: "#F0E9FF".toColor(),
          )
        ],
      ),
    ),
  );
}