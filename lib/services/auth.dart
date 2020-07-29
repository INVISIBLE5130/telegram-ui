import 'package:firebase_auth/firebase_auth.dart';
import 'package:telegram_ui/model/user.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;

  User userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(userId: user.uid) : null;
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );

      FirebaseUser firebaseUser = result.user;
      return userFromFirebaseUser(firebaseUser);
    } catch(e) {
      print(e.toString());
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );

      FirebaseUser firebaseUser = result.user;
      return userFromFirebaseUser(firebaseUser);
    } catch(e) {
      print(e.toString());
    }
  }

  Future resetPassword(String email) async {
    try {
      return await auth.sendPasswordResetEmail(email: email);
    } catch(e) {
      print(e.toString());
    }
  }

  Future signOut() async {
    try {
      return await auth.signOut();
    } catch(e) {
      print(e.toString());
    }
  }
}