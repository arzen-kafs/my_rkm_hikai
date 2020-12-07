import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_rkm_hikai/Activities/Drawer/NavDrawer.dart';
import 'package:my_rkm_hikai/Activities/IntroScreen/welcome.dart';
import 'package:my_rkm_hikai/Activities/Login/login_screen.dart';
import 'package:my_rkm_hikai/core/session.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Session session = Session();

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () => nextPage());
  }

  void nextPage() async {
    var check = await session.getBool("SLIDER_CHECKED");
    if (check == false) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => Welcome()));
    } else {
      var checkLogin = await session.getBool("LOGIN_SUCCESS");
      if (checkLogin == true) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen()));
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => NavDrawer()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final _screen = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        //height: _screen.height*1.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment(0.9, 1.2),
              colors: [const Color(0xfee00000), const Color(0xffeeee00)],
              tileMode: TileMode.repeated),
        ),
        child: SizedBox(
          height: _screen.height * 1.0,
          child: Center(
            //child:SizedBox(height: _screen.height * 1.0,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 50.0, bottom: 50),
                ),
                Text('HIKAI',
                    style: TextStyle(
                      //height: _screen.height * 0.02,
                      color: Colors.black,
                      fontWeight: FontWeight.w100,
                      fontSize: _screen.height * 0.08,
                      letterSpacing: 10,
                      fontFamily: 'PlaySign',
                    )),
                Container(
                  //height: _screen.height*0.02,
                  child: Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: _screen.height * 0.35,
                    ),
                  ),
                ),
                Text('Hybrid Interactive Knowledge Assimilation Initiative',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      //height: _screen.height*0.02,
                      color: Colors.black,
                      fontWeight: FontWeight.w100,
                      fontSize: _screen.height * 0.04,
                      letterSpacing: 6,
                      fontFamily: 'Schoolbell',
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
