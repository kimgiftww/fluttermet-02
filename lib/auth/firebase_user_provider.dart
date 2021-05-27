import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class Fluttermet02FirebaseUser {
  Fluttermet02FirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

Fluttermet02FirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<Fluttermet02FirebaseUser> fluttermet02FirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<Fluttermet02FirebaseUser>(
            (user) => currentUser = Fluttermet02FirebaseUser(user));
