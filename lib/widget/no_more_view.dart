import 'package:flutter/material.dart';

class NoMoreView extends StatelessWidget {
  final Color textColor;

  NoMoreView({this.textColor});

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Text(
        '- 真的没有了 -',
        style: new TextStyle(color: textColor ?? Colors.black87),
      ),
    );
  }
}
