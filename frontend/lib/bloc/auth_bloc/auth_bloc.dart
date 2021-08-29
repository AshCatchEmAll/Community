import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:f/bloc/auth_bloc/auth_repo.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../text_bloc/TextBloc.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextBloc emailBloc = TextBloc();
  TextBloc passwordBloc = TextBloc();
  get currentUserUid => FirebaseAuth.instance.currentUser?.uid;
  get currentUser => FirebaseAuth.instance.currentUser;

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is LoginUserEvent) {
      try {
        yield LoginInProcessState();
        await loginUser(event.email, event.password);
        yield AuthSuccessfulState();
      } catch (e) {
        yield LoginFailedState(error: e.toString());
      }
    } else if (event is SignInUserEvent) {
      try {
        yield SignInProcessState();
        await signInUser(event.email, event.password);
        yield AuthSuccessfulState();
      } catch (e) {
        yield SignInFailedState(error: e.toString());
      }
    } else if (event is SignOutEvent) {
      try {
        yield SignOutInProcessState();
        await signout();
        yield SignOutSuccessfulState();
      } catch (e) {
        yield SignOutFailedState(error: e.toString());
      }
    } else if (event is ResetAuthEvent) {
      yield AuthInitial();
    }
  }

  Future currentUserIdToken() async {
    var id = await _auth.currentUser?.getIdToken(true);
    return id;
  }
}
