import 'package:flutter/material.dart';
import 'package:my_rkm_hikai/Activities/About/About.dart';
import 'package:my_rkm_hikai/Activities/CalendarPage/calendar_page.dart';
import 'package:my_rkm_hikai/Activities/HomePage/home_page.dart';
import 'package:my_rkm_hikai/Activities/SyncHikaiPage/synchikai_page.dart';

import '../class_room.dart';

// ignore: must_be_immutable
class DashBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SchoolManagement(),
      ),
    );
  }
}

class SchoolManagement extends StatefulWidget {
  @override
  _SchoolManagementState createState() => _SchoolManagementState();
}

class _SchoolManagementState extends State<SchoolManagement> {
  int _selectedItemIndex = 0;
  final List pages = [
    HomePage(),
    ClassRoomPage(
      title: "Class Room",
    ),
    SyncHikaiPage(
      title: "Sync Data",
    ),
    CalendarPage(),
    AboutPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            elevation: 0,
            backgroundColor: Color(0xFFF0F0F0),
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.black,
            selectedIconTheme: IconThemeData(color: Colors.blueGrey[600]),
            currentIndex: _selectedItemIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (int index) {
              setState(() {
                _selectedItemIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                title: Text(""),
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                title: Text(""),
                icon: Icon(Icons.class__rounded),
              ),
              BottomNavigationBarItem(
                title: Text(""),
                icon: Icon(Icons.sync),
              ),
              BottomNavigationBarItem(
                title: Text(""),
                icon: Icon(Icons.calendar_today),
              ),
              BottomNavigationBarItem(
                title: Text(""),
                icon: Icon(Icons.info),
              ),
            ],
          ),
          body: pages[_selectedItemIndex]),
    );
  }
}
