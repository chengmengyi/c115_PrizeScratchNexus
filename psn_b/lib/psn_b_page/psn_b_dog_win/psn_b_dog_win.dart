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
    margin: EdgeInsets.only(left: 66.w),
  );

  _contentWidget()=>Container(
    width: double.infinity,
    height: 974.h,
    margin: EdgeInsets.only(left: 66.w,right: 66.w),
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        PsnImageWidget(name: "dog1",width: double.infinity,height: double.infinity,),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 40.h),
            child: PsnPlayLogoAnimatorWidget(image: "dog11", width: 348.w, height: 206.h),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _textWidget(),
            SizedBox(height: 6.h,),
            _guaWidget(),
          ],
        ),
      ],
    ),
  );

  _guaWidget()=>Container(
    width: double.infinity,
    height: 576.h,
    key: psnCon.playUtils.scratchGlobalKey,
    margin: EdgeInsets.only(left: 30.w,right: 30.w,bottom: 46.h),
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
                      height: 115.h,
                      alignment: Alignment.center,
                      child: PsnBreathingWidget(
                        startAnimator: bean.win,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            PsnImageWidget(name: bean.content,width: 99.w,height: 99.h,),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                PsnImageWidget(name: "icon_money",width: 28.w,height: 28.h,),
                                SizedBox(width: 8.w,),
                                PsnGradientText(
                                  data: "${bean.reward}",
                                  gradient: LinearGradient(
                                      colors: ["#FFFFFF".toColor(),"#F6D72A".toColor()],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter
                                  ),
                                  size: 26.sp,
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
    margin: EdgeInsets.only(left: 28.w,right: 28.w),
    child: Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          margin: EdgeInsets.only(top: 30.h),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              PsnImageWidget(name: "dog4",width: double.infinity,height: 124.h,),
              Container(
                margin: EdgeInsets.only(bottom: 23.h),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PsnImageWidget(name: "icon_find",height: 25.h,boxFit: BoxFit.fitHeight,),
                        SizedBox(height: 10.h,),
                        PsnImageWidget(name: "icon_prize",height: 25.h,boxFit: BoxFit.fitHeight,),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(8, (index){
                        return Container(
                          margin: EdgeInsets.only(left: 2.w,right: 2.w),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              PsnImageWidget(name: "beishu${index+3}",height: 25.h,boxFit: BoxFit.fitHeight,),
                              SizedBox(height: 10.h,),
                              PsnImageWidget(name: "beishuX${index+1}",height: 25.h,boxFit: BoxFit.fitHeight,),
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
            PsnImageWidget(name: "dog2",width: 419.w,height: 37.h,),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                PsnTextWidget(text: "FIND DOG", size: 26.sp, color: "#FFFFFF".toColor(),outlineColor: "#131730".toColor(),),
                PsnImageWidget(name: "dog3",width: 59.w,height: 59.w,),
                PsnTextWidget(text: "AND WIN", size: 26.sp, color: "#FFFFFF".toColor(),outlineColor: "#131730".toColor(),),
              ],
            )
          ],
        ),
      ],
    ),
  );
}