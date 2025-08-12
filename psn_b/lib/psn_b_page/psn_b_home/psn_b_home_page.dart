import 'package:flutter/material.dart';
import 'package:psn_b/psn_b_page/psn_b_home/psn_b_home_con.dart';
import 'package:psn_b/psn_b_widget/psn_b_home_top_widget.dart';
import 'package:psn_root/psn_root_page/psn_root_page.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';
import 'package:psn_root/psn_root_widget/psn_click.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';

class PsnBHomePage extends PsnRootPage<PsnBHomeCon>{

  @override
  String bgName() => "bg2";

  @override
  PsnBHomeCon onCon() => PsnBHomeCon();

  @override
  Widget onCreate() => GetBuilder<PsnBHomeCon>(
    id: "page",
    builder: (_)=>Column(
      children: [
        PsnBHomeTopWidget(),
        Expanded(
          child: IndexedStack(
            index: psnCon.tabIndex,
            children: psnCon.pageList,
          ),
        ),
        _bottomBtnWidget(),
      ],
    ),
  );

  _bottomBtnWidget()=>SizedBox(
    width: double.infinity,
    height: 138.h,
    child: Stack(
      children: [
        PsnImageWidget(name: "home4",width: double.infinity,height: double.infinity,),
        MasonryGridView.count(
          padding: const EdgeInsets.all(0),
          itemCount: psnCon.bottomList.length,
          shrinkWrap: true,
          crossAxisCount: 3,
          mainAxisSpacing: 0,
          crossAxisSpacing: 0,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context,index){
            var bean = psnCon.bottomList[index];
            return PsnClick(
              onTap: (){
                psnCon.clickBottomBtn(index);
              },
              child: SizedBox(
                width: double.infinity,
                height: 138.h,
                child: Stack(
                  children: [
                    Visibility(
                      visible: psnCon.tabIndex==index,
                      child: PsnImageWidget(name: "home5",width: double.infinity,height: double.infinity,),
                    ),
                    Align(
                      alignment: psnCon.tabIndex==index?Alignment.topCenter:Alignment.center,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          PsnImageWidget(name: bean.icon,width: 109.w,height: 103.h,),
                          PsnImageWidget(name: bean.text,height: 39.h,boxFit: BoxFit.fitHeight,),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        )
      ],
    ),
  );
}