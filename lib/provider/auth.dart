import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Auth extends ChangeNotifier {
  late String id;
  late String _email;
  late String _password;
  final auth = FirebaseAuth.instance;
  void setEmail(email) {
    _email = email;
  }
  void setPassword(password) {
    _password = password;
  }

  void signIn() {
    auth.signInWithEmailAndPassword(email: _email, password: _password);
  }

  void register() {
    auth.createUserWithEmailAndPassword(email: _email, password: _password);
  }
}
