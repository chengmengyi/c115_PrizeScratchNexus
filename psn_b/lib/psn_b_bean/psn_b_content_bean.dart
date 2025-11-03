import 'package:flutter/material.dart';

class PsnBContentBean {
  String content;
  double reward;
  bool win;
  GlobalKey? globalKey;
  PsnBContentBean({
    required this.content,
    required this.reward,
    required this.win,
    this.globalKey,
});

  @override
  String toString() {
    return 'PsnAContentBean{content: $content, reward: $reward, win: $win}';
  }
}