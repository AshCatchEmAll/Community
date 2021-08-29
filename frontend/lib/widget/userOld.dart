import 'package:flutter/material.dart';
import '../pages/LoginPage.dart';

class UserOld extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 30, bottom: 30),
      child: Container(
        alignment: Alignment.topRight,
        //color: Colors.red,
        height: 20,
        child: Row(
          children: <Widget>[
            Text(
              'Have we met before?  ',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white70,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Text(
                'Sign in',
                style: TextStyle(
                  fontSize: 15,
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
