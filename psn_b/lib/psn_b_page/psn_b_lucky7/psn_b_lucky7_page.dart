import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_page/psn_b_lucky7/psn_b_lucky7_con.dart';
import 'package:psn_b/psn_b_widget/psn_b_guaka_animator_widget.dart';
import 'package:psn_b/psn_b_widget/psn_b_play_base_widget.dart';
import 'package:psn_b/psn_b_widget/psn_play_logo_animator_widget.dart';
import 'package:psn_root/psn_root_page/psn_root_page.dart';
import 'package:psn_root/psn_root_scratcher/scratcher.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_widget/psn_breath_widget.dart';
import 'package:psn_root/psn_root_widget/psn_click.dart';
import 'package:psn_root/psn_root_widget/psn_gradient_text.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';
import 'package:psn_root/psn_root_widget/psn_lottie_widget.dart';
import 'package:psn_root/psn_root_widget/psn_text_widget.dart';

class PsnBLucky7Page extends PsnRootPage<PsnBLucky7Con>{
  @override
  PsnBLucky7Con onCon() => PsnBLucky7Con();

  @override
  String bgName() => "bg1";

  @override
  Widget onCreate() => Stack(
    children: [
      PsnBPlayBaseWidget(
        child: _contentWidget(),
        playUtils: psnCon.playUtils,
        margin: EdgeInsets.only(left: 33.w),
      ),
      _topMoneyFingerWidget(),
    ],
  );

  _contentWidget()=>Container(
    width: double.infinity,
    height: 487.h,
    margin: EdgeInsets.only(left: 33.w,right: 33.w),
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        PsnImageWidget(name: "lucky1",width: double.infinity,height: double.infinity,),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _textWidget(),
            SizedBox(height: 3.h,),
            _guaWidget(),
          ],
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 20.h),
            child: PsnPlayLogoAnimatorWidget(image: "lucky6", width: 254.w, height: 108.h),
          ),
        ),
      ],
    ),
  );

  _guaWidget()=>Container(
    width: double.infinity,
    height: 313.h,
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
          image: Image.asset('assets/images/lucky5.webp',fit: BoxFit.fill,),
          onThreshold: (){
            psnCon.playUtils.onThreshold();
          },
          onScratchUpdate: (details){
            // smController.updateIconOffset(details);
          },
          onScratchStart: (){
            psnCon.onScratchStart();
            // VoicePlayUtils.instance.playGua();
          },
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              PsnImageWidget(name: "lucky2",width: double.infinity,height: double.infinity,),
              GetBuilder<PsnBLucky7Con>(
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
                      height: 62.h,
                      alignment: Alignment.center,
                      child: PsnBreathingWidget(
                        startAnimator: bean.win,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            bean.win?
                            PsnImageWidget(name: bean.content,width: 30.w,height: 27.h,):
                            PsnGradientText(
                              data: bean.content,
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: ["#FBFF00".toColor(),"#FEAC02".toColor()]
                              ),
                              size: 30.sp,
                              outlineColor: "#000000".toColor(),
                            ),
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
        GetBuilder<PsnBLucky7Con>(
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
    height: 20.h,
    alignment: Alignment.center,
    margin: EdgeInsets.only(left: 17.w,right: 17.w),
    decoration: BoxDecoration(
      color: "#E96208".toColor(),
      borderRadius: BorderRadius.circular(10.w),
      border: Border.all(
        width: 1.w,
        color: "#FF9C00".toColor(),
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        PsnTextWidget(text: "Scratch More ", size: 12.sp, color: "#E9F9F6".toColor(),outlineColor: "#000000".toColor(),),
        PsnTextWidget(text: "7s", size: 12.sp, color: "#F9DC04".toColor(),outlineColor: "#000000".toColor(),),
        PsnTextWidget(text: " For Bigger Bonuses! ", size: 12.sp, color: "#E9F9F6".toColor(),outlineColor: "#000000".toColor(),),
      ],
    ),
  );

  _topMoneyFingerWidget()=>Positioned(
    top: 25.h,
    left: 150.w,
    child: GetBuilder<PsnBLucky7Con>(
      id: "top_finger",
      builder: (_)=>Visibility(
        visible: psnCon.showTopFinger,
        child: SafeArea(
          top: true,
          child: PsnClick(
            onTap: (){
              psnCon.clickCash();
            },
            child: PsnLottieWidget(name: "finger",width: 45.w,height: 45.w,),
          ),
        ),
      ),
    ),
  );
}