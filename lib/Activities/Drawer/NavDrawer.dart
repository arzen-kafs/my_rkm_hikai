import 'package:flutter/material.dart';
import 'package:my_rkm_hikai/Activities/About/About.dart';
import 'package:my_rkm_hikai/Activities/ClassRoom/Dashboard/DashBoard.dart';
import 'package:my_rkm_hikai/Activities/ClassRoom/class_room.dart';
import 'package:my_rkm_hikai/Activities/SyncHikaiPage/synchikai_page.dart';
import 'package:my_rkm_hikai/Activities/Web_view/Login.dart';
import 'package:my_rkm_hikai/Activities/Web_view/Notice.dart';
import 'package:my_rkm_hikai/Activities/Web_view/SamplePaper.dart';
import 'package:my_rkm_hikai/core/session.dart';


class NavDrawer extends StatefulWidget {
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  Session session = Session();
  int _currentIndex;
  Widget _currentPage;
  List<Widget> _pages;
  Widget _page1;
  Widget _page2;
  Widget _page3;
  Widget _page4;
  @override
  void initState() {
    super.initState();

    _page1 = DashBoard();
    _page2 = ClassRoomPage();
    _page3 = SyncHikaiPage();
    _page4=AboutPage();

    _pages = [_page1, _page2, _page3,_page4];

    _currentIndex = 0;
    _currentPage = _page1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
          "RKMHIKAI",
          style: TextStyle(color: Colors.black38),
        )),

        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                // decoration: BoxDecoration(
                //   image: DecorationImage(
                //     image: ExactAssetImage('assets/pictures/'),
                //     fit: BoxFit.cover,
                //   ),
                // ),
                currentAccountPicture: CircleAvatar(
                  child: Image.asset(
                    "assets/images/logo.png",
                    height: 200,
                  ),
                ),
                accountName: FutureBuilder<String>(
                    future: getName(),
                    initialData: "Loading...",
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(snapshot.data);
                      } else {
                        return Text("Loading...");
                      }
                    }),
                accountEmail: FutureBuilder<String>(
                    future: getEmail(),
                    initialData: "Loading...",
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(snapshot.data);
                      } else {
                        return Text("Loading...");
                      }
                    }),
              ),
              ListTile(
                  leading: Icon(Icons.home),
                  title: Text("Home"),
                  onTap: () {
                    Navigator.pop(context);
                    changeTab(0);
                  }),
              ListTile(
                  leading: Icon(Icons.class__rounded),
                  title: Text("Class Room"),
                  onTap: () {
                    Navigator.pop(context);
                    changeTab(1);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ClassRoomPage(
                            title: "Class Room",
                          );
                        },
                      ),
                    );
                  }),
              ListTile(
                  leading: Icon(Icons.sync),
                  title: Text("Sync Data"),
                  onTap: () {
                    changeTab(2);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SyncHikaiPage(
                            title: "Sync Data",
                          );
                        },
                      ),
                    );
                  }),
              ListTile(
                  leading: Icon(Icons.web_outlined),
                  title: Text("Jump to RKMHIKAI.online"),
                  onTap: () {
                   // changeTab(3);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  }),
              ListTile(
                  leading: Icon(Icons.notifications),
                  title: Text("Notice Board"),
                  onTap: () {
                   // changeTab(4);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Notice()),
                    );
                  }),
              ListTile(
                  leading: Icon(Icons.book),
                  title: Text("Exam Questions"),
                  onTap: () {
                    changeTab(5);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QuestionPaper()),
                    );
                  }),
              ListTile(
                  leading: Icon(Icons.settings),
                  title: Text("Settings"),
                  onTap: () {
                    Navigator.pop(context);
                  }),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  height: 1.0,
                  width: 130.0,
                  color: Colors.black,
                ),
              ),
              ListTile(
                  leading: Icon(Icons.info),
                  title: Text("About"),
                  onTap: () {
                    changeTab(0);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return AboutPage();
                        },
                      ),
                    );
                  }),
            ],
          ),
        ),
        body: DashBoard());
  }

  Future<String> getName() async {
    var firstname = await session.getString("FIRSTNAME");
    var lastname = await session.getString("LASTNAME");
    return "$firstname $lastname";
  }

  Future<String> getEmail() async {
    var email = await session.getString("EMAIL");
    return "$email";
  }

  void changeTab(int index) {
    setState(() {
      _currentIndex = index;
      _currentPage = _pages[index];
    });
  }
}

