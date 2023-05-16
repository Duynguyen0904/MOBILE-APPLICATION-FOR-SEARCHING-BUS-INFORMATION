// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, deprecated_member_use, prefer_final_fields, unused_field, unused_element, unused_import

import 'package:busmap/home_menu.dart';
import 'package:busmap/map_screen.dart';
import 'package:flutter/material.dart';

class Navi extends StatefulWidget {
  @override
  State<Navi> createState() => _NaviState();
}

class _NaviState extends State<Navi> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    MapScreen(),
    HomeMenu(),
  ];
  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            title: Text('Map'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.place),
            title: Text('Find'),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      ),
    );
  }
}
