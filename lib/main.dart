import 'package:flutter/material.dart';
import 'package:pxnyan/module/home_page.dart';

void main() => runApp(new PxNyanApp());

class PxNyanApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'PxNyan',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new HomePage(),
    );
  }
}
