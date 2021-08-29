import 'package:f/pages/AllTerritories.dart';
import 'package:f/pages/MyMarkers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:f/bloc/auth_bloc/auth_bloc.dart';

class MyDrawer extends StatefulWidget {
  MyDrawer({Key? key, required this.authBloc}) : super(key: key);
  AuthBloc authBloc;
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xff18182a),
              ),
              child: Center(child: Image.asset("assets/logo.png"))),
          ListTile(
            title: const Text('My markers'),
            trailing: Icon(Icons.pin_drop_rounded),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MyMarkers();
              }));
            },
          ),
          ListTile(
            title: const Text('All Markers'),
            trailing: Icon(Icons.all_inclusive_rounded),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AllTerritories();
              }));
            },
          ),
          ListTile(
            title: const Text('Sign out'),
            trailing: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is SignOutInProcessState) {
                  return SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ));
                } else
                  return Icon(Icons.logout_rounded);
              },
            ),
            onTap: () {
              try {
                widget.authBloc.add(SignOutEvent());
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Error signing out : $e")));
              }
            },
          ),
        ],
      ),
    );
  }
}
