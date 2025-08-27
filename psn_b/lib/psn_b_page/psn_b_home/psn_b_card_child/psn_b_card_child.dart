import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_bean/psn_b_card_bean.dart';
import 'package:psn_b/psn_b_page/psn_b_home/psn_b_card_child/psn_b_card_child_con.dart';
import 'package:psn_b/psn_b_utils/pns_b_card_type_enum.dart';
import 'package:psn_b/psn_b_utils/psn_b_utils.dart';
import 'package:psn_b/psn_b_widget/psn_b_card_num_widget.dart';
import 'package:psn_b/psn_b_widget/psn_box_widget.dart';
import 'package:psn_root/psn_root_page/psn_root_child.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_widget/psn_click.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';
import 'package:psn_root/psn_root_widget/psn_text_widget.dart';

class PsnBCardChild extends PsnRootChild<PsnBCardChildCon>{
  @override
  PsnBCardChildCon onCon() => PsnBCardChildCon();

  @override
  Widget onCreate() => Stack(
    children: [
      Align(
        alignment: Alignment.center,
        child: _sliderWidget(),
      ),
      Positioned(
        top: 13.h,
        left: 22.w,
        child: PsnBoxWidget(),
      ),
      Align(
        alignment: Alignment.topRight,
        child: PsnClick(
          onTap: (){
            psnCon.test();
          },
          child: SizedBox(
            width: 50,
            height: 50,
          ),
        ),
      ),
      Positioned(
        right: 10.w,
        bottom: 30.h,
        child: PsnClick(
          onTap: (){
            psnCon.toMoreGame();
          },
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              PsnImageWidget(name: "more_game",width: 133.w,height: 133.w,),
              PsnTextWidget(text: "More Fun", size: 30.sp, color: "#FFFFFF".toColor(),outlineColor: "#160068".toColor(),)
            ],
          ),
        ),
      ),
    ],
  );


  _sliderWidget()=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      _indicatorWidget(),
      SizedBox(height: 36.h,),
      GetBuilder<PsnBCardChildCon>(
        id: "list",
        builder: (_)=>CarouselSlider(
          options: CarouselOptions(
              height: 780.h,
              autoPlay: false,
              enlargeCenterPage: true,
              viewportFraction: 0.65,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
              onPageChanged: (index,reason){
                psnCon.onPageChanged(index);
              }
          ),
          items: psnCon.cardList.map((value)=>_sliderItemWidget(value)).toList(),
        ),
      ),
      SizedBox(height: 60.h,),
      _btnWidget(),
    ],
  );

  Widget _sliderItemWidget(PsnBCardBean value) => Stack(
    children: [
      PsnImageWidget(name: psnCon.getCardIcon(value),width: double.infinity,height: 780.h,),
      PsnBCardNumWidget(cardTypeEnum: PsnBCardTypeEnum.values.byName(value.cardType??"")),
      Align(
        child: Visibility(
          visible: value.unlock==1,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PsnImageWidget(name: "icon_lock",width: 107.w,height: 136.h,),
              SizedBox(height: 20.h,),
              PsnTextWidget(
                text: "Unlock thid game mode at",
                size: 24.sp,
                color: "#FFFFFF".toColor(),
                outlineColor: "#000000".toColor(),
              ),
              SizedBox(height: 20.h,),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PsnTextWidget(
                    text: "Level",
                    size: 24.sp,
                    color: "#FFFFFF".toColor(),
                    outlineColor: "#000000".toColor(),
                  ),
                  PsnTextWidget(
                    text: " ${getLevelByCardType(PsnBCardTypeEnum.values.byName(value.cardType??""))}",
                    size: 24.sp,
                    color: "#FFE400".toColor(),
                    outlineColor: "#000000".toColor(),
                  ),
                ],
              )
            ],
          ),
        ),
      )
    ],
  );

  _indicatorWidget()=>SizedBox(
    height: 26.w,
    child: GetBuilder<PsnBCardChildCon>(
      id: "indicator",
      builder: (_)=>ListView.builder(
        itemCount: psnCon.cardList.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context,index)=>Container(
          margin: EdgeInsets.only(left: 11.w,right: 11.w),
          child: PsnImageWidget(name: index==psnCon.currentIndex?"indicator_sel":"indicator_uns",width: 26.w,height: 26.w,),
        ),
      ),
    ),
  );

  _btnWidget()=>PsnClick(
    onTap: (){
      psnCon.toPlay();
    },
    child: Stack(
      alignment: Alignment.topCenter,
      key: psnCon.playBtnGlobalKey,
      children: [
        PsnImageWidget(name: "home2",width: 357.w,height: 107.h,),
        Container(
          margin: EdgeInsets.only(top: 26.h),
          child: PsnImageWidget(name: "home3",width: 191.w,height: 40.h,),
        ),
      ],
    ),
  );
}