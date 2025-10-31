import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_dialog/psn_b_lucky_card_dialog/psn_b_lucky_card_dialog_con.dart';
import 'package:psn_b/psn_b_widget/psn_b_lucky_card_widget.dart';
import 'package:psn_root/psn_root_page/psn_root_dialog.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_widget/psn_click.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';
import 'package:psn_root/psn_root_widget/psn_lottie_widget.dart';
import 'package:psn_root/psn_root_widget/psn_text_widget.dart';

class PsnBLuckyCardDialog extends PsnRootDialog<PsnBLuckyCardDialogCon>{
  Function() dismissCallback;
  PsnBLuckyCardDialog({
    required this.dismissCallback,
});

  @override
  PsnBLuckyCardDialogCon onCon() => PsnBLuckyCardDialogCon();

  @override
  Widget onCreate() => Container(
    width: double.infinity,
    height: 385.h,
    margin: EdgeInsets.only(left: 29.w,right: 29.w),
    child: Stack(
      children: [
        PsnImageWidget(name: "card1",width: double.infinity,height: double.infinity,),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 16.h),
            child: PsnTextWidget(text: "Lucky Crad", size: 24.sp, color: "#FDEC59".toColor(),outlineColor: "#000000".toColor(),),
          ),
        ),
        Positioned(
          top: 15.h,
          right: 15.w,
          child: PsnClick(
            onTap: (){
              psnCon.clickClose(dismissCallback);
            },
            child: PsnImageWidget(name: "icon_close2",width: 20.w,height: 20.w,),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PsnTextWidget(text: "Jackpot Time!", size: 16.sp, color: "#FDEF5F".toColor(),outlineColor: "#110F0F".toColor(),),
              SizedBox(height: 6.h,),
              PsnTextWidget(text: "Your Big Prize Awaits", size: 16.sp, color: "#F8F2F2".toColor(),outlineColor: "#110F0F".toColor(),),
              SizedBox(height: 15.h,),
              _cardListWidget(),
              SizedBox(height: 15.h,),
            ],
          ),
        ),
      ],
    ),
  );

  _cardListWidget()=>Container(
    width: double.infinity,
    padding: EdgeInsets.all(13.w),
    margin: EdgeInsets.only(left: 15.w,right: 15.w),
    decoration: BoxDecoration(
      color: "#757A7A".toColor().withOpacity(0.2),
      borderRadius: BorderRadius.circular(12.w),
    ),
    child: Stack(
      children: [
        MasonryGridView.count(
          padding: const EdgeInsets.all(0),
          itemCount: 6,
          shrinkWrap: true,
          crossAxisCount: 3,
          mainAxisSpacing: 11.h,
          crossAxisSpacing: 18.w,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context,index)=>PsnBLuckyCardWidget(
            index: index,
            startLuckyCardFlipAnimator: (){
              psnCon.startLuckyCardFlipAnimator();
            },
            clickCardAnimatorEnd: (reward){
              psnCon.clickCardAnimatorEnd(reward,dismissCallback);
            },
          ),
        ),
        Positioned(
          top: 50.h,
          left: 25.w,
          child: GetBuilder<PsnBLuckyCardDialogCon>(
            id: "finger",
            builder: (_)=>Visibility(
              visible: psnCon.showFinger,
              child: IgnorePointer(
                child: PsnLottieWidget(name: "finger",width: 45.w,height: 45.w,),
              ),
            ),
          ),
        )
      ],
    ),
  );
}