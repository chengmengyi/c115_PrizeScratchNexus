import 'dart:async';
import 'package:flutter/material.dart';
import 'package:psn_root/psn_root_utils/psn_root_export.dart';

class MultiStyleTypewriter extends StatefulWidget {
  final List<TextLine> lines;
  final Duration speed;
  final ValueChanged<double>? onProgress;

  const MultiStyleTypewriter({
    super.key,
    required this.lines,
    this.speed = const Duration(milliseconds: 100),
    this.onProgress,
  });

  @override
  State<MultiStyleTypewriter> createState() => _MultiStyleTypewriterState();
}

class _MultiStyleTypewriterState extends State<MultiStyleTypewriter> {
  Timer? _timer;
  int _totalLength = 0;
  int _currentIndex = 0;

  late List<_CharInfo> _charList;

  @override
  void initState() {
    super.initState();
    _prepareText();
    _startTyping();
  }

  void _prepareText() {
    _charList = [];
    for (var line in widget.lines) {
      for (int i = 0; i < line.text.length; i++) {
        _charList.add(_CharInfo(line.text[i], line.style, line.lineIndex));
      }
      // 每行后加一个换行符（除最后一行）
      if (line != widget.lines.last) {
        _charList.add(_CharInfo('\n', line.style, line.lineIndex));
      }
    }
    _totalLength = _charList.length;
  }

  void _startTyping() {
    _timer = Timer.periodic(widget.speed, (timer) {
      if (_currentIndex < _totalLength) {
        setState(() {
          _currentIndex++;
        });
        widget.onProgress?.call(_currentIndex / _totalLength);
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 取当前应该显示的字符
    var visibleChars = _charList.take(_currentIndex).toList();

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 50.w),
      child: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          children: visibleChars.map((c) {
            return TextSpan(
              text: c.char,
              style: c.style,
            );
          }).toList(),
        ),
      ),
    );
  }
}

class TextLine {
  final String text;
  final TextStyle style;
  final int lineIndex;

  TextLine(this.text, this.style, this.lineIndex);
}

class _CharInfo {
  final String char;
  final TextStyle style;
  final int lineIndex;

  _CharInfo(this.char, this.style, this.lineIndex);
}