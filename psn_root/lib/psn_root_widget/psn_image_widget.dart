import 'package:flutter/material.dart';

class PsnImageWidget extends StatelessWidget{
  String name;
  double? width;
  double? height;
  BoxFit? boxFit;
  PsnImageWidget({
    required this.name,
    this.width,
    this.height,
    this.boxFit,
});
  @override
  Widget build(BuildContext context) => Image.asset("assets/images/$name.webp",width: width,height: height,fit: boxFit??BoxFit.fill,);
}