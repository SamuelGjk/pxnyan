import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  final Color textColor;

  EmptyView({this.textColor});

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Text(
        '啥都没有',
        style: new TextStyle(color: textColor ?? Colors.black87),
      ),
    );
  }
}
