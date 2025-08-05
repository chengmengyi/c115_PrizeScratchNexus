import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psn_root/psn_root_page/psn_root_con.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';

abstract class PsnRootDialog<T extends PsnRootCon> extends StatelessWidget{
  late T psnCon;
  bool _initPage=true;

  @override
  Widget build(BuildContext context) {
    _initCon();
    return WillPopScope(
      child: Material(
        type: MaterialType.transparency,
        child: Center(
          child: onCreate(),
        ),
      ),
      onWillPop: ()async{
        return false;
      },
    );
  }

  _initCon(){
    if(_initPage){
      psnCon=Get.put(onCon());
      onStart();
    }
    _initPage=false;
  }

  onStart(){}

  Widget onCreate();

  T onCon();
}