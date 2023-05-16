// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class HomeMenu extends StatefulWidget {
  @override
  _HomeMenuState createState() => _HomeMenuState();
  // ignore: todo
  // TODO: implement createState
}

class _HomeMenuState extends State<HomeMenu> {
  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build
    return SafeArea(
      minimum: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          TextField(
            // ignore: prefer_const_constructors
            decoration: InputDecoration(labelText: 'Search Bus Routes'),
            
          )
        ],
      ),
    );
  }
}
