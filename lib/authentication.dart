import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = new GoogleSignIn();

Future<FirebaseUser> signInWithGoogle() async {
  // Attempt to get the currently authenticated user
  GoogleSignInAccount currentUser = _googleSignIn.currentUser;
  if (currentUser == null) {
    // Attempt to sign in without user interaction
    currentUser = await _googleSignIn.signInSilently();
  }
  if (currentUser == null) {
    // Force the user to interactively sign in
    currentUser = await _googleSignIn.signIn();
  }

  final GoogleSignInAuthentication googleAuth =
      await currentUser.authentication;

  // Authenticate with firebase
  final FirebaseUser user = await firebaseAuth.signInWithGoogle(
    idToken: googleAuth.idToken,
    accessToken: googleAuth.accessToken,
  );

  assert(user != null);
  assert(!user.isAnonymous);

  return user;
}

Future<Null> signOutWithGoogle() async {
  // Sign out with firebase
  await firebaseAuth.signOut();
  // Sign out with google
  await _googleSignIn.signOut();
}
