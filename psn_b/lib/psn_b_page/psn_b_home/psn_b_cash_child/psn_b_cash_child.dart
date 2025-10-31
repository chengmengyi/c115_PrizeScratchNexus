import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_page/psn_b_home/psn_b_cash_child/psn_b_cash_child_con.dart';
import 'package:psn_root/psn_root_page/psn_root_child.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_widget/psn_click.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';
import 'package:psn_root/psn_root_widget/psn_text_widget.dart';

class PsnBCashChild extends PsnRootChild<PsnBCashChildCon>{
  @override
  PsnBCashChildCon onCon() => PsnBCashChildCon();

  @override
  Widget onCreate() => Column(
    children: [
      SizedBox(height: 21.h,),
      _cashTypeWidget(),
      SizedBox(height: 15.h,),
      _cashListWidget(),
    ],
  );

  _cashTypeWidget()=>Container(
    width: double.infinity,
    height: 62.h,
    margin: EdgeInsets.only(left: 5.w),
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: psnCon.cashTypeList.length,
      itemBuilder: (context,index){
        var bean = psnCon.cashTypeList[index];
        return Container(
          margin: EdgeInsets.only(right: 5.w),
          child: PsnClick(
            onTap: (){
              psnCon.clickCashType(index);
            },
            child: PsnImageWidget(name: bean.icon,width: 111.w,height: 62.h,),
          ),
        );
      },
    ),
  );

  _cashListWidget()=>Expanded(
    child: MediaQuery.removePadding(
      context: psnCon.context,
      removeTop: true,
      child: GetBuilder<PsnBCashChildCon>(
        id: "cash_list",
        builder: (_)=>ListView.builder(
          itemCount: psnCon.cashList.length,
          itemBuilder: (context,index){
            var bean = psnCon.cashList[index];
            return PsnClick(
              onTap: (){
                psnCon.clickCashItem(bean);
              },
              child: Container(
                width: double.infinity,
                height: 109.h,
                margin: EdgeInsets.only(left: 13.w,right: 13.w,bottom: 10.h),
                child: Stack(
                  children: [
                    PsnImageWidget(name: psnCon.getCashListBg(),width: double.infinity,height: double.infinity),
                    Positioned(
                      left: 15.w,
                      bottom: 20.h,
                      child: PsnTextWidget(text: "\$${bean.money}", size: 26.sp, color: "#252525".toColor()),
                    ),
                    Positioned(
                      top: 0,
                      right: 20.w,
                      bottom: 0,
                      child: Visibility(
                        visible: (null==bean.cashTaskBean||bean.cashTaskBean?.completed==1)&&null==bean.rankProgress,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            PsnImageWidget(name: "btn_green",width: 139.w,height: 44.h,),
                            PsnTextWidget(text: bean.cashTaskBean?.completed==1?"Success":"Cash Out", size: 18.sp, color: "#FFFFFF".toColor(),outlineColor: "#000000".toColor(),)
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Visibility(
                        visible: (null!=bean.cashTaskBean&&bean.cashTaskBean?.completed!=1)||null!=bean.rankProgress,
                        child: Container(
                          margin: EdgeInsets.only(right: 20.w),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              PsnTextWidget(text: psnCon.getCaskTaskStr(bean), size: 17.sp, color: "#252525".toColor(),),
                              SizedBox(height: 10.h,),
                              SizedBox(
                                width: 171.w,
                                height: 15.h,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 15.h,
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.only(left: 2.w,right: 2.w),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15.w),
                                        color: "#042E53".toColor(),
                                      ),
                                      child: ClipRRect(
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          widthFactor: psnCon.getCashTaskPro(bean),
                                          child: PsnImageWidget(name: "cash1",width: double.infinity,height: 10.h,),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: Visibility(
                        visible: (null!=bean.cashTaskBean&&bean.cashTaskBean?.completed!=1)||null!=bean.rankProgress,
                        child: Container(
                          padding: EdgeInsets.only(left: 8.w,right: 8.w,top: 5.h,bottom: 5.5.h,),
                          decoration: BoxDecoration(
                            color: "#D7489D".toColor(),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(12.w),
                              bottomLeft: Radius.circular(12.w),
                            )
                          ),
                          child: PsnTextWidget(text: "in paying process", size: 14.sp, color: "#FFFFFF".toColor(),),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ),
  );
}