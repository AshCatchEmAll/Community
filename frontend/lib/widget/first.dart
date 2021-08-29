import 'package:flutter/material.dart';
import "../pages/SignupPage.dart";

class FirstTime extends StatefulWidget {
  @override
  _FirstTimeState createState() => _FirstTimeState();
}

class _FirstTimeState extends State<FirstTime> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 30),
      child: Container(
        alignment: Alignment.topRight,
        //color: Colors.red,
        height: 20,
        child: Row(
          children: <Widget>[
            Text(
              'Your first time?     ',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white70,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => SignupPage()));
              },
              child: Text(
                'Sign up',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
