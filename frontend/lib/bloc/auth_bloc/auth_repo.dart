import 'package:firebase_auth/firebase_auth.dart';

Future signInUser(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      throw 'The password provided is too weak.';
    } else if (e.code == 'email-already-in-use') {
      throw 'The account already exists for that email.';
    }
  } catch (e) {
    print(e);
    throw e;
  }
}

Future loginUser(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      throw 'No user found for that email.';
    } else if (e.code == 'wrong-password') {
      throw 'Wrong password provided for that user.';
    }
  } catch (e) {
    print(e);
    throw e;
  }
}

Future signout() async {
  try {
    await FirebaseAuth.instance.signOut();
  } catch (e) {
    throw e;
  }
}

Future getUserIdToken() async {
  var id = await FirebaseAuth.instance.currentUser?.getIdToken(true);
  return id;
}

Future getUID() async {
  return FirebaseAuth.instance.currentUser?.uid;
}
