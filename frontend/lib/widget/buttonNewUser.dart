import 'package:f/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:f/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonNewUser extends StatefulWidget {
  @override
  _ButtonNewUserState createState() => _ButtonNewUserState();
}

class _ButtonNewUserState extends State<ButtonNewUser> {
  late AuthBloc _authBloc;
  @override
  void initState() {
    _authBloc = context.read<AuthBloc>();
    super.initState();
  }

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessfulState) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return HomePage();
          }));
        } else if (state is SignInFailedState) {
          setState(() {
            _isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.redAccent, content: Text(state.error)));
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 40, right: 50, left: 200),
        child: Container(
          alignment: Alignment.bottomRight,
          height: 50,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Color(0xff18182a),
              blurRadius: 10.0, // has the effect of softening the shadow
              spreadRadius: 1.0, // has the effect of extending the shadow
              offset: Offset(
                5.0, // horizontal, move right 10
                5.0, // vertical, move down 10
              ),
            ),
          ], color: Colors.white, borderRadius: BorderRadius.circular(30)),
          child: TextButton(
            onPressed: () async {
              setState(() {
                _isLoading = true;
              });
              try {
                String email = _authBloc.emailBloc.getText();
                String password = _authBloc.passwordBloc.getText();
                _authBloc.emailBloc.clearText();
                _authBloc.passwordBloc.clearText();
                _authBloc
                    .add(SignInUserEvent(email: email, password: password));
              } catch (err) {
                setState(() {
                  _isLoading = false;
                });
              }
            },
            child: _isLoading == true
                ? Center(child: CircularProgressIndicator())
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'OK',
                        style: TextStyle(
                          color: Colors.lightBlueAccent,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.lightBlueAccent,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
