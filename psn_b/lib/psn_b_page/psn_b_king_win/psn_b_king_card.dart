import 'dart:math';

import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_page/psn_b_dog_win/psn_b_dog_win_con.dart';
import 'package:psn_b/psn_b_page/psn_b_king_win/psn_b_king_card_con.dart';
import 'package:psn_b/psn_b_widget/psn_b_play_base_widget.dart';
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
    margin: EdgeInsets.only(left: 66.w),
  );

  _contentWidget()=>Container(
    width: double.infinity,
    height: 974.h,
    margin: EdgeInsets.only(left: 66.w,right: 66.w),
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        PsnImageWidget(name: "king1",width: double.infinity,height: double.infinity,),
        _guaWidget(),
      ],
    ),
  );

  _guaWidget()=>Container(
    width: double.infinity,
    height: 626.h,
    key: psnCon.playUtils.scratchGlobalKey,
    margin: EdgeInsets.only(left: 30.w,right: 30.w,bottom: 46.h),
    child: Scratcher(
      key: psnCon.playUtils.scratcherKey,
      enabled: true,
      brushSize: 40,
      threshold: 40,
      color: Colors.transparent,
      image: Image.asset('assets/images/king2.webp',fit: BoxFit.fill,),
      onThreshold: (){
        psnCon.playUtils.onThreshold();
      },
      onScratchUpdate: (details){
        // smController.updateIconOffset(details);
      },
      onScratchStart: (){
        // luckyController.onScratchStart();
        // VoicePlayUtils.instance.playGua();
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PsnImageWidget(name: "king3",width: double.infinity,height: double.infinity,),
          Container(
            margin: EdgeInsets.only(left: 14.w,right: 14.w,bottom: 14.h),
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
                              height: 110.h,
                              alignment: Alignment.center,
                              child: SizedBox(
                                width: 62.w,
                                height: 88.h,
                                child: Stack(
                                  children: [
                                    PsnImageWidget(name: "kapai$nextInt",width: 62.w,height: 88.h,),
                                    Align(
                                      child: PsnTextWidget(text: bean.content, size: 40.sp, color: textColor.toColor()),
                                    ),
                                    Positioned(
                                      top: 10.h,
                                      right: 10.w,
                                      child: PsnTextWidget(text: bean.content, size: 10.sp, color: textColor.toColor()),
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
                      width: 147.w,
                      child: MediaQuery.removePadding(
                        context: psnCon.context,
                        removeTop: true,
                        removeBottom: true,
                        child: ListView.builder(
                          itemCount: 5,
                          shrinkWrap: true,
                          itemBuilder: (context,index){
                            return Container(
                              width: 147.w,
                              height: 110.h,
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  PsnImageWidget(name: "king7",width: 57.w,height: 52.h,),
                                  SizedBox(height: 2.h,),
                                  PsnGradientText(
                                    data: "${psnCon.playUtils.contentList[index*2].reward}",
                                    gradient: LinearGradient(
                                        colors: ["#FFFFFF".toColor(),"#F6D72A".toColor()],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter
                                    ),
                                    size: 26.sp,
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
  );
}