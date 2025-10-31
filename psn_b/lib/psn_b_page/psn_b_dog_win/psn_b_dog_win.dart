import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_page/psn_b_dog_win/psn_b_dog_win_con.dart';
import 'package:psn_b/psn_b_widget/psn_b_guaka_animator_widget.dart';
import 'package:psn_b/psn_b_widget/psn_b_play_base_widget.dart';
import 'package:psn_b/psn_b_widget/psn_play_logo_animator_widget.dart';
import 'package:psn_root/psn_root_page/psn_root_page.dart';
import 'package:psn_root/psn_root_scratcher/scratcher.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_widget/psn_breath_widget.dart';
import 'package:psn_root/psn_root_widget/psn_gradient_text.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';
import 'package:psn_root/psn_root_widget/psn_text_widget.dart';

class PsnBDogWin extends PsnRootPage<PsnBDogWinCon>{
  @override
  PsnBDogWinCon onCon() => PsnBDogWinCon();

  @override
  String bgName() => "bg1";

  @override
  Widget onCreate() => PsnBPlayBaseWidget(
    child: _contentWidget(),
    playUtils: psnCon.playUtils,
    margin: EdgeInsets.only(left: 33.w),
  );

  _contentWidget()=>Container(
    width: double.infinity,
    height: 487.h,
    margin: EdgeInsets.only(left: 33.w,right: 33.w),
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        PsnImageWidget(name: "dog1",width: double.infinity,height: double.infinity,),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 20.h),
            child: PsnPlayLogoAnimatorWidget(image: "dog11", width: 174.w, height: 103.h),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _textWidget(),
            SizedBox(height: 3.h,),
            _guaWidget(),
          ],
        ),
      ],
    ),
  );

  _guaWidget()=>Container(
    width: double.infinity,
    height: 288.h,
    key: psnCon.playUtils.scratchGlobalKey,
    margin: EdgeInsets.only(left: 15.w,right: 15.w,bottom: 23.h),
    child: Stack(
      children: [
        Scratcher(
          key: psnCon.playUtils.scratcherKey,
          enabled: true,
          brushSize: 40,
          threshold: 40,
          color: Colors.transparent,
          image: Image.asset('assets/images/dog10.webp',fit: BoxFit.fill,),
          onThreshold: (){
            psnCon.playUtils.onThreshold();
          },
          onScratchUpdate: (details){
            // smController.updateIconOffset(details);
          },
          onScratchStart: (){
            psnCon.onScratchStart();
          },
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              PsnImageWidget(name: "dog5",width: double.infinity,height: double.infinity,),
              GetBuilder<PsnBDogWinCon>(
                id: "list",
                builder: (_)=>MasonryGridView.count(
                  padding: const EdgeInsets.all(0),
                  itemCount: psnCon.playUtils.contentList.length,
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index){
                    var bean = psnCon.playUtils.contentList[index];
                    return Container(
                      width: double.infinity,
                      height: 58.h,
                      alignment: Alignment.center,
                      child: PsnBreathingWidget(
                        startAnimator: bean.win,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            PsnImageWidget(name: bean.content,width: 50.w,height: 50.h,),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                PsnImageWidget(name: "icon_money",width: 14.w,height: 14.h,),
                                SizedBox(width: 4.w,),
                                PsnGradientText(
                                  data: "${bean.reward}",
                                  gradient: LinearGradient(
                                      colors: ["#FFFFFF".toColor(),"#F6D72A".toColor()],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter
                                  ),
                                  size: 13.sp,
                                  outlineColor: "#0C0D0E".toColor(),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
        GetBuilder<PsnBDogWinCon>(
          id: "guaka_animator",
          builder: (_)=>Visibility(
            visible: psnCon.showGuaKaAnimator,
            child: IgnorePointer(
              child: PsnBGuakaAnimatorWidget(),
            ),
          ),
        ),
      ],
    ),
  );

  _textWidget()=>Container(
    width: double.infinity,
    margin: EdgeInsets.only(left: 14.w,right: 14.w),
    child: Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          margin: EdgeInsets.only(top: 15.h),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              PsnImageWidget(name: "dog4",width: double.infinity,height: 62.h,),
              Container(
                margin: EdgeInsets.only(bottom: 11.h),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PsnImageWidget(name: "icon_find",height: 12.h,boxFit: BoxFit.fitHeight,),
                        SizedBox(height: 5.h,),
                        PsnImageWidget(name: "icon_prize",height: 12.h,boxFit: BoxFit.fitHeight,),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(8, (index){
                        return Container(
                          margin: EdgeInsets.only(left: 1.w,right: 1.w),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              PsnImageWidget(name: "beishu${index+3}",height: 12.h,boxFit: BoxFit.fitHeight,),
                              SizedBox(height: 10.h,),
                              PsnImageWidget(name: "beishuX${index+1}",height: 12.h,boxFit: BoxFit.fitHeight,),
                            ],
                          ),
                        );
                      }),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            PsnImageWidget(name: "dog2",width: 210.w,height: 18.h,),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                PsnTextWidget(text: "FIND DOG", size: 13.sp, color: "#FFFFFF".toColor(),outlineColor: "#131730".toColor(),),
                PsnImageWidget(name: "dog3",width: 30.w,height: 30.w,),
                PsnTextWidget(text: "AND WIN", size: 13.sp, color: "#FFFFFF".toColor(),outlineColor: "#131730".toColor(),),
              ],
            )
          ],
        ),
      ],
    ),
  );
}