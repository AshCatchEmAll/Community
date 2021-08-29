import 'package:f/bloc/auth_bloc/auth_bloc.dart';
import 'package:f/pages/HomePage.dart';
import 'package:f/pages/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        // BlocProvider(
        //   create: (context) => SubjectBloc(),
        // ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            buttonColor: Color(0xff18182a),
            appBarTheme: AppBarTheme(backgroundColor: Color(0xff18182a)),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Color(0xff18182a))),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessfulState) {
          setState(() {});
        } else if (state is SignOutSuccessfulState) {
          setState(() {});
          print(context.read<AuthBloc>().currentUserUid);
        } else if (state is LoginFailedState || state is SignInFailedState) {
          setState(() {});
        }
      },
      child: context.read<AuthBloc>().currentUserUid == null
          ? LoginPage()
          : HomePage(),
    );
  }
}
