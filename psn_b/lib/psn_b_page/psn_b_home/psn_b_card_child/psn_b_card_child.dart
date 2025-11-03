import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_bean/psn_b_card_bean.dart';
import 'package:psn_b/psn_b_page/psn_b_home/psn_b_card_child/psn_b_card_child_con.dart';
import 'package:psn_b/psn_b_utils/pns_b_card_type_enum.dart';
import 'package:psn_b/psn_b_utils/psn_b_utils.dart';
import 'package:psn_b/psn_b_widget/psn_b_card_num_widget.dart';
import 'package:psn_b/psn_b_widget/psn_box_widget.dart';
import 'package:psn_b/psn_b_widget/psn_card_lock_widget.dart';
import 'package:psn_root/psn_root_page/psn_root_child.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_widget/psn_click.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';
import 'package:psn_root/psn_root_widget/psn_spine_widget.dart';
import 'package:psn_root/psn_root_widget/psn_tap_scale_widget.dart';
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
        top: 6.h,
        left: 11.w,
        child: PsnBoxWidget(
          globalKey: psnCon.boxGlobalKey,
        ),
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
        right: 5.w,
        bottom: 15.h,
        child: PsnClick(
          onTap: (){
            psnCon.toMoreGame();
          },
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              PsnImageWidget(name: "more_game",width: 66.w,height: 66.w,),
              PsnTextWidget(text: "More Fun", size: 15.sp, color: "#FFFFFF".toColor(),outlineColor: "#160068".toColor(),)
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
      SizedBox(height: 19.h,),
      GetBuilder<PsnBCardChildCon>(
        id: "list",
        builder: (_)=>CarouselSlider(
          carouselController: psnCon.carouselSliderControllerImpl,
          options: CarouselOptions(
              height: 390.h,
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
      SizedBox(height: 30.h,),
      _btnWidget(),
    ],
  );

  Widget _sliderItemWidget(PsnBCardBean value) => PsnTapScaleWidget(
    onTap: (){
      psnCon.toPlay();
    },
    child: Stack(
      key: value.cardType==PsnBCardTypeEnum.lucky7.name?psnCon.firstPlayCardGlobalKey:null,
      children: [
        PsnImageWidget(name: getCardIcon(value),width: double.infinity,height: 390.h,),
        PsnBCardNumWidget(cardTypeEnum: PsnBCardTypeEnum.values.byName(value.cardType??"")),
        Align(
          child: PsnCardLockWidget(cardBean: value),
          // child: Visibility(
          //   visible: value.unlock==1,
          //   child: Column(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       // PsnImageWidget(name: "icon_lock",width: 53.w,height: 68.h,),
          //       PsnSpineWidget(atlasFile: "skeletons", skeletonFile: "skeleton", animatorName: "animation", folder: "jiesuo", width: 53.w, height: 68.w),
          //       SizedBox(height: 10.h,),
          //       PsnTextWidget(
          //         text: "Unlock thid game mode at",
          //         size: 12.sp,
          //         color: "#FFFFFF".toColor(),
          //         outlineColor: "#000000".toColor(),
          //       ),
          //       SizedBox(height: 10.h,),
          //       Row(
          //         mainAxisSize: MainAxisSize.min,
          //         children: [
          //           PsnTextWidget(
          //             text: "Level",
          //             size: 12.sp,
          //             color: "#FFFFFF".toColor(),
          //             outlineColor: "#000000".toColor(),
          //           ),
          //           PsnTextWidget(
          //             text: " ${getLevelByCardType(PsnBCardTypeEnum.values.byName(value.cardType??""))}",
          //             size: 12.sp,
          //             color: "#FFE400".toColor(),
          //             outlineColor: "#000000".toColor(),
          //           ),
          //         ],
          //       )
          //     ],
          //   ),
          // ),
        ),
      ],
    ),
  );

  _indicatorWidget()=>SizedBox(
    height: 13.w,
    child: GetBuilder<PsnBCardChildCon>(
      id: "indicator",
      builder: (_)=>ListView.builder(
        itemCount: psnCon.cardList.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context,index)=>Container(
          margin: EdgeInsets.only(left: 5.w,right: 5.w),
          child: PsnImageWidget(name: index==psnCon.currentIndex?"indicator_sel":"indicator_uns",width: 13.w,height: 13.w,),
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
        PsnImageWidget(name: "home2",width: 178.w,height: 54.h,),
        Container(
          margin: EdgeInsets.only(top: 13.h),
          child: PsnImageWidget(name: "home3",width: 96.w,height: 20.h,),
        ),
      ],
    ),
  );
}