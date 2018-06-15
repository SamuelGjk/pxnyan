import 'package:flutter/material.dart';

class NoMoreView extends StatelessWidget {
  final Color textColor;

  NoMoreView({this.textColor});

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: new Text(
          '- 真的没有了 -',
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
