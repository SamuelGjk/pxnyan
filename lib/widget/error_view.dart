import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final Color textColor;
  final GestureTapCallback onTap;

  ErrorView(this.onTap, {this.textColor});

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: onTap,
      child: new Center(
        child: new Text(
          '出错了，请点击重试',
          style: new TextStyle(
            color: textColor ?? Colors.black54,
            fontSize: 14.0,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.w200,
          ),
        ),
      ),
    );
  }
}
