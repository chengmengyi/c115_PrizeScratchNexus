import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_page/psn_b_number/psn_b_number_con.dart';
import 'package:psn_b/psn_b_widget/psn_b_play_base_widget.dart';
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
    margin: EdgeInsets.only(left: 66.w),
  );

  _contentWidget()=>Container(
    width: double.infinity,
    height: 974.h,
    margin: EdgeInsets.only(left: 66.w,right: 66.w),
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        PsnImageWidget(name: "number1",width: double.infinity,height: double.infinity,),
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
    height: 506.h,
    key: psnCon.playUtils.scratchGlobalKey,
    margin: EdgeInsets.only(left: 30.w,right: 30.w,bottom: 46.h),
    child: Scratcher(
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
                  height: 126.h,
                  alignment: Alignment.center,
                  child: PsnBreathingWidget(
                    startAnimator: bean.win,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        PsnTextWidget(text: bean.content, size: 50.sp, color: "#FDFF1B".toColor(),outlineColor: "#FF4E00".toColor(),),
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
  );

  _textWidget()=>Container(
    width: double.infinity,
    margin: EdgeInsets.only(left: 47.w,right: 47.w),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            PsnImageWidget(name: "number4",width: double.infinity,height: 35.h,),
            PsnTextWidget(text: "WIN NUMBER", size: 26.sp, color: "#FFFFFF".toColor(),outlineColor: "#FF7200".toColor(),)
          ],
        ),
        SizedBox(height: 12.h,),
        SizedBox(
          height: 93.h,
          child: GetBuilder<PsnBNumberCon>(
            id: "win",
            builder: (_)=>ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: psnCon.specialNumbersList.length,
              itemBuilder: (context,index)=>Container(
                margin: EdgeInsets.only(left: 16.w,right: 16.w),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    PsnImageWidget(name: "number5",width: 129.w,height: 93.h,),
                    PsnTextWidget(text: "${psnCon.specialNumbersList[index]}", size: 50.sp, color: "#FDFF1B".toColor(),outlineColor: "#FF4E00".toColor(),)
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 12.h,),
        Stack(
          alignment: Alignment.center,
          children: [
            PsnImageWidget(name: "number4",width: double.infinity,height: 35.h,),
            PsnTextWidget(text: "YOUR NUMBER", size: 26.sp, color: "#FFFFFF".toColor(),outlineColor: "#FF7200".toColor(),)
          ],
        ),
        SizedBox(height: 12.h,),
      ],
    ),
  );
}