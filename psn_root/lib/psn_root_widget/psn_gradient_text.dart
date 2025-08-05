import 'package:flutter/material.dart';
import 'package:psn_root/psn_root_widget/psn_text_widget.dart';

class PsnGradientText extends StatelessWidget {

  String data;
  double size;
  Gradient gradient;
  Color? outlineColor;

  PsnGradientText({
    required this.data,
    required this.gradient,
    required this.size,
    this.outlineColor,
  });
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return gradient.createShader(Offset.zero & bounds.size);
      },
      child: PsnTextWidget(text: data, size: size, color: Colors.white,outlineColor: outlineColor,),
    );
  }
}
