import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_dialog/psn_box_dialog/psn_box_dialog_con.dart';
import 'package:psn_b/psn_b_widget/psn_b_btn_widget.dart';
import 'package:psn_root/psn_root_page/psn_root_dialog.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_utils/psn_root_utils.dart';
import 'package:psn_root/psn_root_widget/psn_click.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';
import 'package:psn_root/psn_root_widget/psn_spine_widget.dart';
import 'package:psn_root/psn_root_widget/psn_text_widget.dart';

class PsnBoxDialog extends PsnRootDialog<PsnBoxDialogCon>{
  Function() dismissCallback;
  PsnBoxDialog({
    required this.dismissCallback,
});
  @override
  PsnBoxDialogCon onCon() => PsnBoxDialogCon();

  @override
  Widget onCreate() => Container(
    width: double.infinity,
    margin: EdgeInsets.only(left: 15.w,right: 15.w),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        PsnImageWidget(name: "box1",width: double.infinity,height: 122.h,),
        GetBuilder<PsnBoxDialogCon>(
          id: "box",
          builder: (_)=>Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _boxItemWidget(0),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _boxItemWidget(1),
                  _boxItemWidget(2),
                ],
              ),
            ],
          ),
        ),
        Visibility(
          child: PsnBBtnWidget(
            text: "Double",
            bgName: "btn_green",
            showVideoIcon: true,
            onTap: (){
              psnCon.clickGetAll(dismissCallback);
            },
          ),
        ),
        SizedBox(height: 30.h,),
        PsnClick(
          onTap: (){
            psnCon.clickClose(dismissCallback);
          },
          child: PsnImageWidget(name: "icon_close",width: 70.w,height: 70.w,),
        )
      ],
    ),
  );

  _boxItemWidget(int index){
    var bean = psnCon.boxList[index];
    return PsnClick(
      onTap: (){
        psnCon.clickBox(bean);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          PsnSpineWidget(
            atlasFile: "baoxiang",
            skeletonFile: "skeleton",
            animatorName: "animation",
            folder: "box",
            width: 300.w,
            height: 270.w,
            controller: bean.controller,
          ),
          Visibility(
            visible: bean.open,
            child: PsnTextWidget(text: "+\$100", size: 50.sp, color: "#FFFFFF".toColor(),outlineColor: "#000000".toColor(),),
          ),
        ],
      ),
    );
  }
}