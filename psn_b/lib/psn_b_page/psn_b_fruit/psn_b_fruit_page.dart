import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_page/psn_b_fruit/psn_b_fruit_con.dart';
import 'package:psn_b/psn_b_widget/psn_b_play_base_widget.dart';
import 'package:psn_root/psn_root_page/psn_root_page.dart';
import 'package:psn_root/psn_root_scratcher/scratcher.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_widget/psn_breath_widget.dart';
import 'package:psn_root/psn_root_widget/psn_gradient_text.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';
import 'package:psn_root/psn_root_widget/psn_text_widget.dart';

class PsnBFruitPage extends PsnRootPage<PsnBFruitCon>{
  @override
  PsnBFruitCon onCon() => PsnBFruitCon();

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
        PsnImageWidget(name: "fruit1",width: double.infinity,height: double.infinity,),
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
    height: 626.h,
    key: psnCon.playUtils.scratchGlobalKey,
    margin: EdgeInsets.only(left: 30.w,right: 30.w,bottom: 46.h),
    child: Scratcher(
      key: psnCon.playUtils.scratcherKey,
      enabled: true,
      brushSize: 40,
      threshold: 40,
      color: Colors.transparent,
      image: Image.asset('assets/images/fruit4.webp',fit: BoxFit.fill,),
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
          PsnImageWidget(name: "fruit3",width: double.infinity,height: double.infinity,),
          GetBuilder<PsnBFruitCon>(
            id: "list",
            builder: (_){
              var length = psnCon.playUtils.contentList.length;
              if(length!=12){
                return Container();
              }
              return Row(
                children: [
                  Expanded(
                    child: MasonryGridView.count(
                      padding: const EdgeInsets.all(0),
                      itemCount: length,
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 0,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context,index){
                        var bean = psnCon.playUtils.contentList[index];
                        return PsnBreathingWidget(
                          startAnimator: bean.win,
                          child: Container(
                            width: double.infinity,
                            height: 146.h,
                            alignment: Alignment.center,
                            child: PsnImageWidget(name: bean.content,height: 101.h,boxFit: BoxFit.fitHeight,),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: 124.w,
                    child: MediaQuery.removePadding(
                      context: psnCon.context,
                      removeTop: true,
                      removeBottom: true,
                      child: ListView.builder(
                        itemCount: 4,
                        shrinkWrap: true,
                        itemBuilder: (context,index){
                          return Container(
                            width: 124.w,
                            height: 148.h,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                PsnImageWidget(name: "king7",width: 57.w,height: 52.h,),
                                SizedBox(height: 2.h,),
                                PsnGradientText(
                                  data: "${psnCon.playUtils.contentList[index*3].reward}",
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
          )
        ],
      ),
    ),
  );

  _textWidget()=>Container(
    width: double.infinity,
    height: 41.h,
    margin: EdgeInsets.only(left: 34.w,right: 34.w),
    child: Stack(
      alignment: Alignment.center,
      children: [
        PsnImageWidget(name: "fruit2",width: double.infinity,height: 41.h,),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            PsnTextWidget(text: "FIND ", size: 24.sp, color: "#E9F9F6".toColor(),outlineColor: "#000000".toColor(),),
            PsnTextWidget(text: "3", size: 24.sp, color: "#F9DC04".toColor(),outlineColor: "#000000".toColor(),),
            PsnTextWidget(text: " IDENTICAL SYMBOLS IN SAME ROW", size: 24.sp, color: "#E9F9F6".toColor(),outlineColor: "#000000".toColor(),),
          ],
        ),
      ],
    ),
  );
}