import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:my_rkm_hikai/Activities/Drawer/NavDrawer.dart';
import 'package:my_rkm_hikai/Global/rounded_button.dart';
import 'package:my_rkm_hikai/Global/rounded_input_field.dart';
import 'package:my_rkm_hikai/Global/rounded_password_field.dart';
import 'package:my_rkm_hikai/core/session.dart';

import 'background.dart';

class Body extends StatefulWidget {

  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool pasword_visible=true;
  Session session=Session();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
            SizedBox(height: size.height * 0.04),
            Text(
              "SIGN IN",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Raleway',
                  fontSize: 40),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              controller: (emailController),
              hintText: "Roll No",
              icon: Icons.folder_shared_outlined,
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              password_visible: true,
              controller: (passwordController),
              hintText: "Password",
              onChanged: (value) {},
            ),
            RoundedButton(
              color: Color(0xff0062cc),
              text: "Sign in",
              textColor: Colors.white,
              press: ()  async {

                print("Click");
                var userExists =
                    await signIn(emailController.text, passwordController.text);
                if (userExists == true) {

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return NavDrawer();
                      },
                    ),
                  );
                } else {
                  Fluttertoast.showToast(
                      msg: "Roll No and Password not found",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.TOP,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black38,
                      textColor: Colors.white,
                      fontSize: 12.0);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<String> getServer() async {
    var server = await session.getString("SERVER_URL");
    return "$server";
  }
}

//Controllers for the username and the password
final TextEditingController emailController = new TextEditingController();
final TextEditingController passwordController = new TextEditingController();

//Code for signing the user in
Future<bool> signIn(String email, pass) async {
  Session session = Session();
  //Left hand side of the map should be the same as the fields in the server
  print("==============INSIDE SIGN================");
  Map data = {'username': email, 'password': pass};
  print(data);
  var jsonResponse;
  var serverUrl = await session.getString("SERVER_URL");

  var response =
      await http.post(serverUrl + "/Authentication/identify", body: data);
  print("========RESPONSE==========");
  print(response.toString());
  if (response.statusCode == 200) {
    jsonResponse = json.decode(response.body);
    print("======JSON============");
    print(jsonResponse);
    if (jsonResponse["success"] == 1) {
      print(jsonResponse["success"]);
      print(jsonResponse);
      var jdata = jsonResponse["data"];
      print(jdata[0]["id"]);
      session.addBool("LOGIN_SUCCESS", true);
      session.addString("ID", jdata[0]["id"]);
      session.addString("PARTICIPANTID", jdata[0]["participantID"]);
      session.addString("FIRSTNAME", jdata[0]["firstName"]);
      session.addString("LASTNAME", jdata[0]["lastName"]);
      session.addString("STANDARD", jdata[0]["class"]);
      session.addString("STREAM", jdata[0]["stream"]);
      session.addString("EMAIL", jdata[0]["email"]);
      session.addString("PHONE", jdata[0]["phone"]);
      return true;
    } else {
      return false;
    }
  } else {
    return false;
  }

}
