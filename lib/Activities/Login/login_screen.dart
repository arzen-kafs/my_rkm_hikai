import 'package:flutter/material.dart';
import 'package:my_rkm_hikai/Global/rounded_input_field.dart';
import 'package:my_rkm_hikai/core/session.dart';
import 'package:my_rkm_hikai/Activities/Login/Components/body.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Session session = Session();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          _networkSelectionBottomSheet(context);
        },
        child: new Icon(Icons.connected_tv),
      ),
    );
  }

  void _networkSelectionBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.menu),
                  title: Text(
                    'Select the server',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Divider(),
                ListTile(
                    leading: Icon(Icons.web),
                    title: Text('RKMHIKAI.ONLINE'),
                    onTap: () async {
                      print("Clicked");
                      session.addString(
                          "SERVER_URL", "https://rkmhikai.online");
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: Icon(Icons.computer),
                  title: Text('School Local Server'),
                  onTap: () {
                    _showMyDialog();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.mobile_off),
                  title: Text('Local Server'),
                  onTap: () {
                    _showMyDialog();
                  },
                ),
              ],
            ),
          );
        });
  }

  void _showMyDialog() async {
    final TextEditingController serverController = new TextEditingController();
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('SERVER URL'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[

                RoundedInputField(
                  formFieldValidator: (value) {
                    if (value.isEmpty) {
                      return "Field should not be empty";
                    }
                    return null;
                  },
                  hintText: "https://192.168.75.120",
                  icon: Icons.miscellaneous_services_sharp,
                  controller: (serverController),
                  onChanged: (value) {},
                )

                //Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Save'),
              onPressed: () {
                session.addString("SERVER_URL", serverController.text);
                Text(Session().getString("SERVER_URL").toString());
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
