// ignore_for_file: use_key_in_widget_constructors, annotate_overrides, unnecessary_new, prefer_const_constructors, deprecated_member_use, unused_import

import 'package:busmap/navi.dart';
import 'package:flutter/material.dart';
import 'package:busmap/map_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Navi(),
    );
  }
}

