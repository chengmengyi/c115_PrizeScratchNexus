import 'dart:math';

import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_page/psn_b_dog_win/psn_b_dog_win_con.dart';
import 'package:psn_b/psn_b_page/psn_b_king_win/psn_b_king_card_con.dart';
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

class PsnBKingCard extends PsnRootPage<PsnBKingCardCon>{
  @override
  PsnBKingCardCon onCon() => PsnBKingCardCon();

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
        PsnImageWidget(name: "king1",width: double.infinity,height: double.infinity,),
        _guaWidget(),
        Align(
          alignment: Alignment.topCenter,
          child: PsnPlayLogoAnimatorWidget(image: "king9", width: 221.w, height: 145.h),
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
          image: Image.asset('assets/images/king8.webp',fit: BoxFit.fill,),
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
              PsnImageWidget(name: "king3",width: double.infinity,height: double.infinity,),
              Container(
                margin: EdgeInsets.only(left: 7.w,right: 7.w,bottom: 7.h),
                child: GetBuilder<PsnBKingCardCon>(
                  id: "list",
                  builder: (_){
                    var length = psnCon.playUtils.contentList.length;
                    if(length!=10){
                      return Container();
                    }
                    return Row(
                      children: [
                        Expanded(
                          child: MasonryGridView.count(
                            padding: const EdgeInsets.all(0),
                            itemCount: length,
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            mainAxisSpacing: 0,
                            crossAxisSpacing: 0,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context,index){
                              var bean = psnCon.playUtils.contentList[index];
                              var nextInt = Random().nextInt(4);
                              var textColor=nextInt==0||nextInt==3?"#E95E64":"#000000";
                              return PsnBreathingWidget(
                                startAnimator: bean.win,
                                child: Container(
                                  width: double.infinity,
                                  height: 55.h,
                                  key: bean.globalKey,
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    width: 31.w,
                                    height: 44.h,
                                    child: Stack(
                                      children: [
                                        PsnImageWidget(name: "kapai$nextInt",width: 31.w,height: 44.h,),
                                        Align(
                                          child: PsnTextWidget(text: bean.content, size: 20.sp, color: textColor.toColor()),
                                        ),
                                        Positioned(
                                          top: 5.h,
                                          right: 5.w,
                                          child: PsnTextWidget(text: bean.content, size: 4.sp, color: textColor.toColor()),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: 73.w,
                          child: MediaQuery.removePadding(
                            context: psnCon.context,
                            removeTop: true,
                            removeBottom: true,
                            child: ListView.builder(
                              itemCount: 5,
                              shrinkWrap: true,
                              itemBuilder: (context,index){
                                return Container(
                                  width: 73.w,
                                  height: 55.h,
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      PsnImageWidget(name: "icon_money",width: 28.w,height: 26.h,),
                                      SizedBox(height: 1.h,),
                                      PsnGradientText(
                                        data: "${psnCon.playUtils.contentList[index*2].reward}",
                                        gradient: LinearGradient(
                                            colors: ["#FFFFFF".toColor(),"#F6D72A".toColor()],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter
                                        ),
                                        size: 13.sp,
                                        outlineColor: "#0C0D0E".toColor(),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
        GetBuilder<PsnBKingCardCon>(
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
}