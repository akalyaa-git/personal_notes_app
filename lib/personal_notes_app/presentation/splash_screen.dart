import 'package:flutter/material.dart';
import 'package:personal_notes_app/personal_notes_app/presentation/login_screen.dart';

/// Splash Screen shown at app launch before navigating to the login screen.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen(); // Calls the method to navigate after a delay
  }

  /// Navigate to the next screen (LoginScreen) after a delay.
  void _navigateToNextScreen() async {
    await Future.delayed(
      Duration(seconds: 2),
    ); // Wait for 2 seconds before navigating
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ), // Navigate to LoginScreen
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[200], // Set splash screen background color
      body: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Center content vertically
          children: [
            Icon(
              Icons.sticky_note_2_outlined,
              size: 100,
              color: Colors.indigo,
            ), // Icon for the splash screen

            SizedBox(height: 10), // Space between icon and text

            Text(
              'Notesly', // App name displayed in the splash screen
              style: TextStyle(
                fontSize: 50, // Large font size for the app name
                color: Colors.indigo, // Text color
                fontWeight: FontWeight.bold, // Bold text for emphasis
              ),
            ),
          ],
        ),
      ),
    );
  }
}
