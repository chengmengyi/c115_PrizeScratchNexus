import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_page/psn_b_collector_win/psn_b_collector_win_con.dart';
import 'package:psn_b/psn_b_widget/psn_b_play_base_widget.dart';
import 'package:psn_root/psn_root_page/psn_root_page.dart';
import 'package:psn_root/psn_root_scratcher/scratcher.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_widget/psn_breath_widget.dart';
import 'package:psn_root/psn_root_widget/psn_gradient_text.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';
import 'package:psn_root/psn_root_widget/psn_text_widget.dart';

class PsnBCollectorWin extends PsnRootPage<PsnBCollectorWinCon>{
  @override
  PsnBCollectorWinCon onCon() => PsnBCollectorWinCon();

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
        PsnImageWidget(name: "collector1",width: double.infinity,height: double.infinity,),
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
      image: Image.asset('assets/images/collector3.webp',fit: BoxFit.fill,),
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
          PsnImageWidget(name: "collector4",width: double.infinity,height: double.infinity,),
          GetBuilder<PsnBCollectorWinCon>(
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
                  height: 125.h,
                  alignment: Alignment.center,
                  child: PsnBreathingWidget(
                    startAnimator: bean.win,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        PsnImageWidget(name: bean.content,height: 68.h,boxFit: BoxFit.fitHeight,),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            PsnImageWidget(name: "icon_coins2",width: 28.w,height: 28.h,),
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
  );

  _textWidget()=>Container(
    width: double.infinity,
    height: 41.h,
    margin: EdgeInsets.only(left: 34.w,right: 34.w),
    child: Stack(
      alignment: Alignment.center,
      children: [
        PsnImageWidget(name: "collector2",width: double.infinity,height: 41.h,),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            PsnTextWidget(text: "Find ", size: 24.sp, color: "#E9F9F6".toColor(),outlineColor: "#000000".toColor(),),
            PsnTextWidget(text: "3", size: 24.sp, color: "#F9DC04".toColor(),outlineColor: "#000000".toColor(),),
            PsnTextWidget(text: " Identical Collectibles", size: 24.sp, color: "#E9F9F6".toColor(),outlineColor: "#000000".toColor(),),
          ],
        ),
      ],
    ),
  );
}