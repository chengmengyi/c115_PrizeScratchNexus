import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_bean/psn_rank_bean.dart';
import 'package:psn_b/psn_b_dialog/psn_rank_dialog/psn_rank_dialog_con.dart';
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
    margin: EdgeInsets.only(left: 49.w,right: 49.w),
    decoration: BoxDecoration(
      color: "#FFFFFF".toColor(),
      borderRadius: BorderRadius.circular(15.w),
    ),
    child: Stack(
      alignment: Alignment.topCenter,
      children: [
        _contentWidget(),
        Positioned(
          top: 10.h,
          right: 10.w,
          child: PsnClick(
            onTap: (){
              psnCon.clickClose();
            },
            child: PsnImageWidget(name: "icon_close3",width: 25.w,height: 25.w,),
          ),
        ),
      ],
    ),
  );

  _contentWidget()=>Container(
    margin: EdgeInsets.only(left: 17.w,right: 17.w),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 17.h,),
        PsnTextWidget(text: "Payment in progress", size: 19.sp, color: "#000000".toColor(),fontFamily: null,),
        SizedBox(height: 17.h,),
        _progressWidget(),
        PsnTextWidget(text: "One Last Step", size: 19.sp, color: "#000000".toColor(),fontFamily: null,),
        SizedBox(height: 25.h,),
        _rankTextWidget(),
        SizedBox(height: 3.h,),
        _rankListWidget(),
        SizedBox(height: 10.h,),
        PsnTextWidget(text: "We have secured the bank's VIP channel，no need to wait to watch ads, \$${rankBean.cashMoney??0} Cash out faster！", size: 15.sp, color: "#000000".toColor(),fontFamily: null,),
        SizedBox(height: 20.h,),
        PsnClick(
          onTap: (){
            psnCon.clickSkip();
          },
          child: Container(
            width: double.infinity,
            height: 48.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: "#356ECA".toColor(),
              borderRadius: BorderRadius.circular(12.w),
            ),
            child: PsnTextWidget(text: "Skip Wait", size: 16.sp, color: "#FFFFFF".toColor(),fontFamily: null,),
          ),
        ),
        SizedBox(height: 20.h,),
      ],
    ),
  );

  _rankListWidget()=>Container(
    width: double.infinity,
    height: 235.h,
    decoration: BoxDecoration(
      color: "#F7F7F7".toColor(),
      borderRadius: BorderRadius.circular(8.w),
    ),
    child: Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 35.h,
          child: Row(
            children: [
              Expanded(
                child: Center(
                  child: PsnTextWidget(text: "User ID", size: 12.sp, color: "#000000".toColor(),fontFamily: null,),
                ),
              ),
              Expanded(
                child: Center(
                  child: PsnTextWidget(text: "Account", size: 12.sp, color: "#000000".toColor(),fontFamily: null,),
                ),
              ),
              Expanded(
                child: Center(
                  child: PsnTextWidget(text: "Amount", size: 12.sp, color: "#000000".toColor(),fontFamily: null,),
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
                  color: bean.isMe?"#FFF5E8".toColor():index%2==0?"#ECECEC".toColor():"#F7F7F7".toColor(),
                  child: Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: PsnTextWidget(text: psnCon.getUserId(index+1), size: 14.sp, color: bean.isMe?"#DA4500".toColor():"#000000".toColor(),fontFamily: null,),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: PsnTextWidget(text: bean.account, size: 14.sp, color: bean.isMe?"#DA4500".toColor():"#000000".toColor(),fontFamily: null,),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: PsnTextWidget(text: "\$${bean.amount}", size: 14.sp, color: bean.isMe?"#DA4500".toColor():"#000000".toColor(),fontFamily: null,),
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
                  fontSize: 13.sp,
                  color: "#067000".toColor(),
                  fontWeight: FontWeight.bold
              ),
            ),
            TextSpan(
              text: " in queue,Your Current rank ",
              style: TextStyle(
                  fontSize: 13.sp,
                  color: "#000000".toColor(),
                  fontWeight: FontWeight.bold
              ),
            ),
            TextSpan(
              text: "${rankBean.currentRank??1}",
              style: TextStyle(
                  fontSize: 13.sp,
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
        height: 14.w,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              width: double.infinity,
              height: 7.h,
              color: "#EFEFEF".toColor(),
              margin: EdgeInsets.only(left: 7.w,right: 7.w),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: 7.h,
                      color: "#00C220".toColor(),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 14.w,
                height: 14.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.w),
                  color: "#EFEFEF".toColor(),
                ),
                child: Container(
                  width: 9.w,
                  height: 9.w,
                  decoration: BoxDecoration(
                    color: "#00C220".toColor(),
                    borderRadius: BorderRadius.circular(4.w),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 14.w,
                height: 14.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.w),
                  color: "#EFEFEF".toColor(),
                ),
                child: Container(
                  width: 9.w,
                  height: 9.w,
                  decoration: BoxDecoration(
                    color: "#00C220".toColor(),
                    borderRadius: BorderRadius.circular(4.w),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 14.w,
                height: 14.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.w),
                  color: "#EFEFEF".toColor(),
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        width: double.infinity,
        height: 50.h,
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
              child: PsnTextWidget(text: "Funds\nreceived", size: 12.sp, color: "#8D8D8D".toColor(),textAlign: TextAlign.end,),
            ),
          ],
        ),
      ),
    ],
  );
}