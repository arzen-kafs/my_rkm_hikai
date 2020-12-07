import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Services.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    final CallsAndMessagesService _service = locator<CallsAndMessagesService>();
    final String number = "+91364235242";
    final String email = "rkmhikaionline@gmail.com";
    return Scaffold(
      backgroundColor: Colors.blueGrey.withOpacity(.8),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: Container(
                height: height * .4,
                decoration: BoxDecoration(),
                child: Container(
                  width: double.infinity,
                  height: 350.0,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.white10,
                          child: Image.asset(
                            "assets/images/logo.png",
                            height: 500,
                          ),
                          radius: 80.0,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "RKM HIKAI",
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Card(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 5.0),
                          clipBehavior: Clip.antiAlias,
                          color: Colors.white,
                          elevation: 5.0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 22.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    FlatButton(
                                      onPressed: () {},
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.email,
                                          size: 40.0,
                                        ),
                                        color: Colors.pink,
                                        onPressed: () {
                                          _service.call(email);
                                        },
                                      ),
                                    ),
                                    Text(
                                      "Email",
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 2.0,
                                    ),
                                    FlatButton(
                                      onPressed: () {},
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.call,
                                          size: 40.0,
                                        ),
                                        color: Colors.pink,
                                        onPressed: () {
                                          _service.sendEmail(number);
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      "Call",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 30.0, horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "About RKM HIKAI",
                      style: TextStyle(
                          color: Colors.redAccent,
                          fontStyle: FontStyle.normal,
                          fontSize: 28.0),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'The Hybrid Interactive Knowledge Assimilation Initiative (HIKAI) being launched by Ramakrishna Mission to provide structured curriculum as per the Board syllabus to all school-going students in Meghalaya.\n'
                      'You are aware that the schools are not allowed to function in normal mode by the Government fearing community spread of COVID19.',
                      style: TextStyle(
                        fontFamily: "Raleway",
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
