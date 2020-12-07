import 'package:flutter/material.dart';
import 'package:my_rkm_hikai/core/session.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Session session = Session();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              //color: Color(0xFFD4E7FE),
              gradient: LinearGradient(
                  colors: [
                    Color(0xFFD4E7FE),
                    Color(0xFFF0F0F0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.6, 0.3])),
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            children: [
              Container(
                  alignment: Alignment.topRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.wifi,
                        size: 16,
                      ),
                      FutureBuilder<String>(
                        future: getServer(),
                        initialData: "Loading...",
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              " ${snapshot.data}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                                color: Color(0XFF343E87),
                              ),
                            );
                          } else {
                            return Text("Loading...");
                          }
                        },
                      )
                    ],
                  )),
              SizedBox(
                height: 15,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 1, color: Colors.white),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueGrey.withOpacity(0.2),
                          blurRadius: 12,
                          spreadRadius: 8,
                        )
                      ],
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/logo.png")),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder<String>(
                        future: getName(),
                        initialData: "Loading...",
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              "Hi ${snapshot.data}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: Color(0XFF343E87),
                              ),
                            );
                          } else {
                            return Text("Loading...");
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FutureBuilder<String>(
                        future: getRollNo(),
                        initialData: "Loading...",
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Row(
                              children: [
                                Icon(
                                  Icons.book,
                                  color: Colors.blueGrey,
                                  size: 14.0,
                                ),
                                Text(
                                  "Roll No: ${snapshot.data}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Text("Loading...");
                          }
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      FutureBuilder<String>(
                        future: getClass(),
                        initialData: "Loading...",
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Row(
                              children: [
                                Icon(
                                  Icons.class_,
                                  color: Colors.blueGrey,
                                  size: 14.0,
                                ),
                                Text(
                                  "${snapshot.data}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Text("Loading...");
                          }
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      FutureBuilder<String>(
                        future: getPhone(),
                        initialData: "Loading...",
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Row(
                              children: [
                                Icon(
                                  Icons.phone_android,
                                  color: Colors.blueGrey,
                                  size: 14.0,
                                ),
                                Text(
                                  " ${snapshot.data}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Text("Loading...");
                          }
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      FutureBuilder<String>(
                        future: getEmail(),
                        initialData: "Loading...",
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Row(
                              children: [
                                Icon(
                                  Icons.email,
                                  color: Colors.blueGrey,
                                  size: 14.0,
                                ),
                                Text(
                                  " ${snapshot.data}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Text("Loading...");
                          }
                        },
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
        Positioned(
          top: 230,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            height: MediaQuery.of(context).size.height - 345,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: ListView(
              physics: ClampingScrollPhysics(),
              children: [
                buildTitleRow("TODAY CLASSES", 3),
                SizedBox(
                  height: 20,
                ),
                buildClassItem(),
                buildClassItem(),
                buildClassItem(),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Row buildTitleRow(String title, int number) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
              text: title,
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: "($number)",
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal),
                ),
              ]),
        ),
        Text(
          "See all",
          style: TextStyle(
              fontSize: 12,
              color: Color(0XFF3E3993),
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Container buildClassItem() {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(10),
      height: 100,
      decoration: BoxDecoration(
        color: Color(0xFFF9F9FB),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "07:00",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "AM",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
              ),
            ],
          ),
          Container(
            height: 100,
            width: 1,
            color: Colors.grey.withOpacity(0.5),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 160,
                child: Text(
                  "The Basic of Typography II",
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.grey,
                    size: 20,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 160,
                    child: Text(
                      "Room C1, Faculty of Art & Design Building",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Gabriel Sutton",
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<String> getName() async {
    var firstname = await session.getString("FIRSTNAME");
    var lastname = await session.getString("LASTNAME");
    return "$firstname $lastname";
  }

  Future<String> getEmail() async {
    var email = await session.getString("EMAIL");
    return "Email: $email";
  }

  Future<String> getRollNo() async {
    var rollno = await session.getString("PARTICIPANTID");
    return "$rollno";
  }

  Future<String> getClass() async {
    var standard = await session.getString("STANDARD");
    var stream = await session.getString("STREAM");
    if (stream == "NA") {
      return "Class: $standard";
    } else {
      return "Class: $standard Stream: $stream";
    }
  }

  Future<String> getPhone() async {
    var phone = await session.getString("PHONE");
    return "Phone No: $phone";
  }

  Future<String> getServer() async {
    var server = await session.getString("SERVER_URL");
    return "$server";
  }
}
