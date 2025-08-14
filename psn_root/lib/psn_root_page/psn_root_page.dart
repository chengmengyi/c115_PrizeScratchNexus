import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psn_root/psn_root_page/psn_root_con.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';

abstract class PsnRootPage<T extends PsnRootCon> extends StatelessWidget{
  late T psnCon;
  bool _initPage=true;

  @override
  Widget build(BuildContext context) {
    _initCon(context);
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          bgName().isEmpty?Container():PsnImageWidget(name: bgName(), width: double.infinity, height: double.infinity),
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: onCreate(),
          ),
        ],
      ),
      resizeToAvoidBottomInset: resizeToAvoidBottomInset(),
    );
  }

  _initCon(BuildContext context){
    if(_initPage){
      psnCon=Get.put(onCon());
      onStart();
    }
    psnCon.context=context;
    _initPage=false;
  }

  onStart(){}

  Widget onCreate();

  T onCon();

  String bgName();

  resizeToAvoidBottomInset()=>true;
}