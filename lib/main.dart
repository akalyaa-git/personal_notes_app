import 'package:firebase_core/firebase_core.dart'; // Import Firebase core package
import 'package:flutter/foundation.dart'; // Import foundation for platform checks (kIsWeb)
import 'package:flutter/material.dart'; // Import Flutter material design package
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:personal_notes_app/personal_notes_app/presentation/splash_screen.dart'; // Import Splash Screen

// Entry point for the app, runs when the app starts
void main() async {
  // Ensure that the widgets are bound to the Flutter engine before initializing Firebase
  WidgetsFlutterBinding.ensureInitialized();

  // Ensure that the dotenv file is loaded before any other code
  await dotenv.load(fileName: 'assets/.env');
  print(dotenv.env['FIREBASE_API_KEY']); // This should print your API key

  // Firebase initialization for different platforms
  if (kIsWeb) {
    // For web, use FirebaseOptions to initialize the Firebase app
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: dotenv.env['FIREBASE_API_KEY']!,
        authDomain: dotenv.env['FIREBASE_AUTH_DOMAIN']!,
        projectId: dotenv.env['FIREBASE_PROJECT_ID']!,
        storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET']!,
        messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID']!,
        appId: dotenv.env['FIREBASE_APP_ID']!,
        measurementId: dotenv.env['FIREBASE_MEASUREMENT_ID']!,
      ),
    );
  } else {
    // For mobile platforms (iOS/Android), simply initialize Firebase
    await Firebase.initializeApp();
  }

  // Once Firebase is initialized, run the app
  runApp(const MyApp());
}

// Main widget of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Constructor for MyApp class

  // Build method to return the app UI
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notesly', // The title of the app
      debugShowCheckedModeBanner:
          false, // Disable the debug banner on the top right
      home:
          const SplashScreen(), // Initial screen that will be displayed (SplashScreen)
    );
  }
}
