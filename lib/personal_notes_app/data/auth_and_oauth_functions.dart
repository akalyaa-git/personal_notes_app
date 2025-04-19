import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:personal_notes_app/personal_notes_app/presentation/login_screen.dart';
import 'package:personal_notes_app/personal_notes_app/presentation/notes_list_screen.dart';

/// Registers a new user using email and password.
Future<void> signUp(
  String emailAddress,
  String password,
  BuildContext context,
) async {
  try {
    // Create a new user with email and password
    final credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
          email: emailAddress,
          password: password,
        );
    debugPrint('SignIn Success');
    // Navigate to LoginScreen after successful signup
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  } on FirebaseAuthException catch (e) {
    // Handle specific Firebase auth errors
    if (e.code == 'weak-password') {
      debugPrint('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      debugPrint('The account already exists for that email.');
    }
  } catch (e) {
    // Catch-all for any other type of error
    debugPrint(e as String?); // Note: casting like this can be risky
  }
}

/// Logs in an existing user using email and password.
Future<void> login(
  String emailAddress,
  String password,
  BuildContext context,
) async {
  try {
    debugPrint('Attempting login...');

    // Attempt to sign in with the provided credentials
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );

    debugPrint('Login Success');

    // Navigate to the notes list after login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => NotesListScreen()),
    );
  } on FirebaseAuthException catch (e) {
    // Handle specific auth errors
    if (e.code == 'user-not-found') {
      debugPrint('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      debugPrint('Wrong password provided for that user.');
    }
  }
}

/// Signs out the current user and navigates back to LoginScreen.
Future<void> signOut(BuildContext context) async {
  debugPrint('Logout Success');

  // Perform sign-out
  await FirebaseAuth.instance.signOut();

  // Redirect to login screen
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => LoginScreen()),
  );
}

/// Handles Google Sign-In using Firebase.
Future<void> signInWithGoogle() async {
  final GoogleSignIn googleSignIn = GoogleSignIn(
    clientId:
        kIsWeb
            ? '454763185380-hu1ukh4lhb4mke3hgqvn8lkjus4m0rn1.apps.googleusercontent.com'
            : null, // Client ID only needed for web
  );

  try {
    // Begin the Google Sign-In flow
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    // Obtain the authentication details
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a Firebase credential from the Google auth tokens
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Sign in to Firebase using the Google credential
    await FirebaseAuth.instance.signInWithCredential(credential);
    debugPrint("✅ Logged in!");
  } catch (e) {
    // Handle errors from the Google sign-in process
    debugPrint("❌ Google Sign-In failed: $e");
  }
}
