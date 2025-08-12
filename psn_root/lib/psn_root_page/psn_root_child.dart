import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psn_root/psn_root_page/psn_root_con.dart';
import 'package:psn_root/psn_root_widget/psn_image_widget.dart';

abstract class PsnRootChild<T extends PsnRootCon> extends StatelessWidget{
  late T psnCon;
  bool _initPage=true;

  @override
  Widget build(BuildContext context) {
    _initCon(context);
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: onCreate(),
    );
  }

  _initCon(BuildContext context){
    if(_initPage){
      psnCon=Get.put(onCon());
      psnCon.context=context;
      onStart();
    }
    _initPage=false;
  }

  onStart(){}

  Widget onCreate();

  T onCon();
}