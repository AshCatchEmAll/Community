import 'package:flutter/material.dart';
import '../widget/buttonNewUser.dart';
import '../widget/newEmail.dart';
import '../widget/newName.dart';
import '../widget/password.dart';
import '../widget/singup.dart';
import '../widget/textNew.dart';
import '../widget/userOld.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blueGrey, Color(0xff18182a)]),
        ),
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SingUp(),
                    TextNew(),
                  ],
                ),
                // NewNome(),
                NewEmail(),
                PasswordInput(),
                ButtonNewUser(),
                UserOld(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
