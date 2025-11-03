import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_bean/psn_rank_bean.dart';
import 'package:psn_b/psn_b_dialog/psn_rank_dialog/psn_rank_dialog_con.dart';
import 'package:psn_b/psn_b_widget/psn_b_btn_widget.dart';
import 'package:psn_root/psn_root_page/psn_root_dialog.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_widget/psn_click.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';
import 'package:psn_root/psn_root_widget/psn_text_widget.dart';

class PsnRankDialog extends PsnRootDialog<PsnRankDialogCon>{
  PsnRankBean rankBean;
  Function() successCallback;
  PsnRankDialog({
    required this.rankBean,
    required this.successCallback,
});

  @override
  PsnRankDialogCon onCon() => PsnRankDialogCon();

  @override
  onStart() {
    psnCon.rankBean=rankBean;
    psnCon.successCallback=successCallback;
  }

  @override
  Widget onCreate() => Container(
    width: double.infinity,
    height: 544.h,
    margin: EdgeInsets.only(left: 29.w,right: 29.w),
    child: Stack(
      children: [
        PsnImageWidget(name: "rank3",width: double.infinity,height: double.infinity,),
        Positioned(
          top: 15.h,
          right: 15.w,
          child: PsnClick(
            onTap: (){
              psnCon.clickClose();
            },
            child: PsnImageWidget(name: "icon_close2",width: 20.w,height: 20.w,),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            margin: EdgeInsets.only(left: 14.w,right: 14.w,top: 70.h,bottom: 20.h),
            child: Column(
              children: [
                _progressWidget(),
                SizedBox(height: 25.h,),
                PsnTextWidget(text: "One Last Step", size: 16.sp, color: "#000000".toColor(),fontWeight: FontWeight.bold,fontFamily: null,),
                SizedBox(height: 4.h,),
                _rankTextWidget(),
                SizedBox(height: 4.h,),
                _rankListWidget(),
                SizedBox(height: 10.h,),
                PsnTextWidget(text: "We have secured the bank's VIP channel，no need to wait to watch ads, \$${rankBean.cashMoney??0} Cash out faster！", size: 15.sp, color: "#000000".toColor(),fontFamily: null,fontWeight: FontWeight.bold,),
                SizedBox(height: 20.h,),
                PsnBBtnWidget(
                  text: "Skip Wait",
                  bgName: "btn_blue",
                  onTap: (){
                    psnCon.clickSkip();
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  _rankListWidget()=>Expanded(
    child: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: "#ecf2f4".toColor(),
        borderRadius: BorderRadius.circular(8.w),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 25.h,
            decoration: BoxDecoration(
              color: "#c6d5d9".toColor(),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.w),
                topRight: Radius.circular(8.w),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Center(
                    child: PsnTextWidget(text: "User ID", size: 12.sp, color: "#314E79".toColor(),fontFamily: null,fontWeight: FontWeight.bold,),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: PsnTextWidget(text: "Account", size: 12.sp, color: "#314E79".toColor(),fontFamily: null,fontWeight: FontWeight.bold,),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: PsnTextWidget(text: "Amount", size: 12.sp, color: "#314E79".toColor(),fontFamily: null,fontWeight: FontWeight.bold,),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GetBuilder<PsnRankDialogCon>(
              id: "list",
              builder: (_)=>ListView.builder(
                itemCount: psnCon.ranList.length,
                controller: psnCon.scrollController,
                itemBuilder: (context,index){
                  var bean = psnCon.ranList[index];
                  return Container(
                    width: double.infinity,
                    height: 25.h,
                    // color: bean.isMe?"#FFF5E8".toColor():index%2==0?"#ECECEC".toColor():"#F7F7F7".toColor(),
                    child: Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: PsnTextWidget(text: psnCon.getUserId(index+1), size: 12.sp, color: bean.isMe?"#DA4500".toColor():"#273A55".toColor(),fontFamily: null,fontWeight: FontWeight.bold,),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: PsnTextWidget(text: bean.account, size: 12.sp, color: bean.isMe?"#DA4500".toColor():"#273A55".toColor(),fontFamily: null,fontWeight: FontWeight.bold,),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: PsnTextWidget(text: "\$${bean.amount}", size: 12.sp, color: bean.isMe?"#DA4500".toColor():"#0E9B00".toColor(),fontFamily: null,fontWeight: FontWeight.bold,),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    ),
  );

  _rankTextWidget()=>GetBuilder<PsnRankDialogCon>(
    id: "rank_text",
    builder: (_)=>RichText(
      text: TextSpan(
          children: [
            //228 in queue， Your Current rank  22
            TextSpan(
              text: "${rankBean.totalRank??400}",
              style: TextStyle(
                  fontSize: 16.sp,
                  color: "#FF0000".toColor(),
                  fontWeight: FontWeight.bold
              ),
            ),
            TextSpan(
              text: " in queue,Your Current rank ",
              style: TextStyle(
                  fontSize: 16.sp,
                  color: "#000000".toColor(),
                  fontWeight: FontWeight.bold
              ),
            ),
            TextSpan(
              text: "${rankBean.currentRank??1}",
              style: TextStyle(
                  fontSize: 16.sp,
                  color: "#067000".toColor(),
                  fontWeight: FontWeight.bold
              ),
            ),
          ]
      ),
    ),
  );

  _progressWidget()=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(
        width: double.infinity,
        height: 22.w,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              width: double.infinity,
              height: 10.h,
              color: "#000000".toColor(),
              margin: EdgeInsets.only(left: 7.w,right: 7.w),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 22.w,
                height: 22.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11.w),
                  color: "#000000".toColor(),
                ),
                child: Container(
                  width: 14.w,
                  height: 14.w,
                  decoration: BoxDecoration(
                    color: "#57FF46".toColor(),
                    borderRadius: BorderRadius.circular(7.w),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 22.w,
                height: 22.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11.w),
                  color: "#000000".toColor(),
                ),
                child: Container(
                  width: 14.w,
                  height: 14.w,
                  decoration: BoxDecoration(
                    color: "#57FF46".toColor(),
                    borderRadius: BorderRadius.circular(7.w),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 22.w,
                height: 22.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11.w),
                  color: "#000000".toColor(),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 10.h,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 7.w,right: 7.w),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: 7.h,
                      color: "#57FF46".toColor(),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        width: double.infinity,
        height: 20.h,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: PsnTextWidget(text: "Review", size: 12.sp, color: "#067000".toColor()),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: PsnTextWidget(text: "Queue", size: 12.sp, color: "#067000".toColor()),
            ),
            Align(
              alignment: Alignment.topRight,
              child: PsnTextWidget(text: "Funds received", size: 12.sp, color: "#8D8D8D".toColor(),textAlign: TextAlign.end,),
            ),
          ],
        ),
      ),
      SizedBox(
        width: double.infinity,
        height: 42.h,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: PsnImageWidget(name: "rank4",width: 50.w,height: 35.h,),
            ),
            Align(
              alignment: Alignment.center,
              child: PsnImageWidget(name: "rank5",width: 56.w,height: 60.h,),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: PsnImageWidget(name: "rank6",width: 66.w,height: 42.h,),
            ),
          ],
        ),
      ),
    ],
  );
}