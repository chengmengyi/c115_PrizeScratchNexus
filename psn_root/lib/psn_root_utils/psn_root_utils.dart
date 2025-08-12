import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

extension StColor on String{
  Color toColor(){
    var hexStr = replaceAll("#", "");
    return Color(int.parse(hexStr, radix: 16)).withAlpha(255);
  }
}

extension ShowToast on String{
  showToast(){
    if(isEmpty){
      return;
    }
    Fluttertoast.showToast(
      msg: this,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black45,
      textColor: Colors.white,
      fontSize: 16,
    );
  }
}

double twoNumAdd(num1,num2){
  try{
    return (Decimal.parse("$num1")+Decimal.parse("$num2")).toDouble();
  }catch(e){
    return 0.0;
  }
}

double twoNumMul(num1,num2){
  try{
    return (Decimal.parse("$num1")*Decimal.parse("$num2")).toDouble();
  }catch(e){
    return 0.0;
  }
}