import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_page/psn_b_number/psn_b_number_con.dart';
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

class PsnBNumberPage extends PsnRootPage<PsnBNumberCon>{
  @override
  PsnBNumberCon onCon() => PsnBNumberCon();

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
        PsnImageWidget(name: "number1",width: double.infinity,height: double.infinity,),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 20.h),
            child: PsnPlayLogoAnimatorWidget(image: "number7", width: 175.w, height: 100.h),
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
    height: 253.h,
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
          image: Image.asset('assets/images/number6.webp',fit: BoxFit.fill,),
          onThreshold: (){
            psnCon.playUtils.onThreshold();
          },
          onScratchUpdate: (details){
          },
          onScratchStart: (){
            psnCon.onScratchStart();
          },
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              PsnImageWidget(name: "number3",width: double.infinity,height: double.infinity,),
              GetBuilder<PsnBNumberCon>(
                id: "list",
                builder: (_)=>MasonryGridView.count(
                  padding: const EdgeInsets.all(0),
                  itemCount: psnCon.playUtils.contentList.length,
                  shrinkWrap: true,
                  crossAxisCount: 4,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index){
                    var bean = psnCon.playUtils.contentList[index];
                    return Container(
                      width: double.infinity,
                      height: 63.h,
                      key: bean.globalKey,
                      alignment: Alignment.center,
                      child: PsnBreathingWidget(
                        startAnimator: bean.win,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            PsnTextWidget(text: bean.content, size: 25.sp, color: "#FDFF1B".toColor(),outlineColor: "#FF4E00".toColor(),),
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
        GetBuilder<PsnBNumberCon>(
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
    margin: EdgeInsets.only(left: 23.w,right: 23.w),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            PsnImageWidget(name: "number4",width: double.infinity,height: 17.h,),
            PsnTextWidget(text: "WIN NUMBER", size: 13.sp, color: "#FFFFFF".toColor(),outlineColor: "#FF7200".toColor(),)
          ],
        ),
        SizedBox(height: 6.h,),
        SizedBox(
          height: 46.h,
          child: GetBuilder<PsnBNumberCon>(
            id: "win",
            builder: (_)=>ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: psnCon.specialNumbersList.length,
              itemBuilder: (context,index)=>Container(
                margin: EdgeInsets.only(left: 8.w,right: 8.w),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    PsnImageWidget(name: "number5",width: 64.w,height: 46.h,),
                    PsnTextWidget(text: "${psnCon.specialNumbersList[index]}", size: 25.sp, color: "#FDFF1B".toColor(),outlineColor: "#FF4E00".toColor(),)
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 6.h,),
        Stack(
          alignment: Alignment.center,
          children: [
            PsnImageWidget(name: "number4",width: double.infinity,height: 17.h,),
            PsnTextWidget(text: "YOUR NUMBER", size: 13.sp, color: "#FFFFFF".toColor(),outlineColor: "#FF7200".toColor(),)
          ],
        ),
        SizedBox(height: 6.h,),
      ],
    ),
  );
}