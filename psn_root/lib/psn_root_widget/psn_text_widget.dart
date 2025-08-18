import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:outlined_text/outlined_text.dart';

class PsnTextWidget extends StatelessWidget{
  String text;
  double size;
  Color color;
  FontWeight? fontWeight;
  Color? outlineColor;
  TextDecoration? textDecoration;
  Color? decorationColor;
  TextAlign? textAlign;

  PsnTextWidget({
    required this.text,
    required this.size,
    required this.color,
    this.outlineColor,
    this.fontWeight,
    this.textDecoration,
    this.decorationColor,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedText(
      text: Text(
        text,
        style: TextStyle(
          fontSize: size,
          color: color,
          fontWeight: fontWeight,
          fontFamily: "bold",
          height: 1,
          decoration: textDecoration,
          decorationColor: decorationColor,
        ),
        textAlign: textAlign,
      ),
      strokes: outlineColor==null?
      []:
      [
        OutlinedTextStroke(
          color: outlineColor??Colors.white,
          width: 4.w,
        ),
      ],
    );
  }
}