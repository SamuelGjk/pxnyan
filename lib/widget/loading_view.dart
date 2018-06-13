import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  final bool show;

  LoadingView(this.show);

  @override
  Widget build(BuildContext context) {
    return new Opacity(
      opacity: show ? 1.0 : 0.0,
      child: new Center(
        child: new Container(
          width: 25.0,
          height: 25.0,
          child: const CircularProgressIndicator(
            strokeWidth: 2.0,
          ),
        ),
      ),
    );
  }
}