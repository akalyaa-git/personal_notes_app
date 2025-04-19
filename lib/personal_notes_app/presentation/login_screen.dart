import 'package:flutter/material.dart';
import 'package:personal_notes_app/personal_notes_app/data/auth_and_oauth_functions.dart';

/// Login and Signup screen for Notesly app.
/// Handles email/password and Google sign-in.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // State variables for user input
  String username = '';
  String email = '';
  String password = '';
  bool isLogin = false; // toggles between login and signup

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notesly',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.cyan,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Username field – only shown in signup mode
              isLogin
                  ? TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter your username',
                    ),
                    key: ValueKey('username'),
                    // Note: Username is currently not used — consider implementing or removing
                  )
                  : Container(),

              // Email input
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter your email address',
                ),
                key: ValueKey('email'),
                onSaved: (value) {
                  email = value!;
                },
              ),
              SizedBox(height: 10),

              // Password input
              TextFormField(
                decoration: InputDecoration(hintText: 'Enter your password'),
                key: ValueKey('password'),
                onSaved: (value) {
                  password = value!;
                },
              ),
              SizedBox(height: 20),

              // Login button (only visible in login mode)
              isLogin
                  ? Container()
                  : ElevatedButton(
                    onPressed: () {
                      _formKey.currentState?.save(); // Save form field values
                      login(email, password, context); // Call login method
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      backgroundColor: Colors.cyan,
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),

              SizedBox(height: 20),

              // Switch between login and signup
              TextButton(
                onPressed: () {
                  setState(() {
                    isLogin = !isLogin;
                  });
                },
                child: Text(
                  isLogin ? 'Switch to Login' : 'Switch to Sign Up',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.indigo,
                  ),
                ),
              ),

              SizedBox(height: 30),

              // Signup button (only visible in signup mode)
              isLogin
                  ? ElevatedButton(
                    onPressed: () {
                      _formKey.currentState?.save(); // Save form field values
                      signUp(email, password, context); // Call signup method
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      backgroundColor: Colors.cyan,
                    ),
                    child: Text(
                      'SignUp',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  )
                  : Container(),

              isLogin ? Container() : Divider(),

              SizedBox(height: 20),

              // Google OAuth button (only in login mode)
              isLogin
                  ? Container()
                  : ElevatedButton(
                    onPressed: () {
                      signInWithGoogle(); // Call Google Sign-in method
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      backgroundColor: Colors.cyan,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('assets/google_icon.png', height: 25),
                        SizedBox(width: 10),
                        Text(
                          'Continue with Google',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
