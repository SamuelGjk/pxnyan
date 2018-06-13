import 'package:flutter/material.dart';
import 'dart:math' as math;

class CornerLabel extends StatelessWidget {
  final String _text;

  CornerLabel(this._text);

  @override
  Widget build(BuildContext context) {
    return new ClipPath(
      clipper: new _TriangleClip(), // 用 Path 切个三角形
      child: new Container(
        width: 30.0,
        height: 30.0,
        color: Colors.blue,
        child: new Transform.rotate(
          angle: math.pi / 4, // 45°
          child: new Transform.translate(
            offset: new Offset(0.0, -8.0),
            child: new Container(
              alignment: AlignmentDirectional.center,
              width: 30.0,
              height: 30.0,
              child: new Text(
                _text,
                style: const TextStyle(fontSize: 12.0, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TriangleClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) => new Path()
    ..lineTo(size.width, 0.0)
    ..lineTo(size.width, size.height)
    ..close();

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
