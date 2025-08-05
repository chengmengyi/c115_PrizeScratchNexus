import 'package:flutter/material.dart';

class PsnClick extends StatelessWidget{
  Widget? child;
  Function()? onTap;
  PsnClick({
    this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) => InkWell(
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    onTap: (){
      onTap?.call();
    },
    child: child??Container(),
  );
}