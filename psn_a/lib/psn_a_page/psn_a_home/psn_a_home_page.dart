import 'package:flutter/material.dart';
import 'package:psn_a/psn_a_bean/psn_a_card_bean.dart';
import 'package:psn_a/psn_a_page/psn_a_home/psn_a_home_con.dart';
import 'package:psn_a/psn_a_utils/pns_a_card_type_enum.dart';
import 'package:psn_a/psn_a_utils/psn_a_utils.dart';
import 'package:psn_a/psn_a_widget/psn_a_card_num_widget.dart';
import 'package:psn_a/psn_a_widget/psn_a_home_top_widget.dart';
import 'package:psn_root/psn_root_page/psn_root_page.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_widget/psn_click.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';
import 'package:psn_root/psn_root_widget/psn_text_widget.dart';

class PsnAHomePage extends PsnRootPage<PsnAHomeCon>{

  @override
  String bgName() => "bg2";

  @override
  PsnAHomeCon onCon() => PsnAHomeCon();

  @override
  Widget onCreate() => Column(
    children: [
      PsnAHomeTopWidget(),
      Expanded(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: _sliderWidget(),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: PsnClick(
                onTap: (){
                  psnCon.test();
                },
                child: SizedBox(
                  width: 50,
                  height: 50,
                ),
              ),
            )
          ],
        ),
      ),
    ],
  );

  _sliderWidget()=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      _indicatorWidget(),
      SizedBox(height: 36.h,),
      GetBuilder<PsnAHomeCon>(
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

  Widget _sliderItemWidget(PsnACardBean value) => Stack(
    children: [
      PsnImageWidget(name: psnCon.getCardIcon(value),width: double.infinity,height: 780.h,),
      PsnACardNumWidget(cardTypeEnum: PsnACardTypeEnum.values.byName(value.cardType??"")),
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
                    text: " ${getLevelByCardType(PsnACardTypeEnum.values.byName(value.cardType??""))}",
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
    child: GetBuilder<PsnAHomeCon>(
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