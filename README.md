# Personal Notes App
A simple and user-friendly mobile app built with Flutter that allows users to add, edit, delete, and manage their notes with Firebase Authentication and Firestore integration.

# Features
* Authentication: Users can sign up, log in, and log out using Email/Password or Google OAuth.
* Notes Management: Users can view, add, edit, and delete notes. The notes are stored in Firebase Firestore.
* Responsive UI: The app is built to work seamlessly on both Android and iOS devices.
* Splash Screen: A welcoming splash screen that shows the app logo before redirecting to the login screen.

# Installation
Follow these steps to get your development environment set up for the Personal Notes App:
* Prerequisites
- Flutter installed on your machine.
- A Firebase project created with Firebase Authentication and Firestore enabled.
- A code editor (e.g., Visual Studio Code).

* Setup Firebase
- Create a Firebase project:
- Go to the Firebase Console.
- Create a new project.
- Add your app to the Firebase project (for iOS/Android).

* Enable Firebase Authentication:
- Go to the Firebase Console.
- In the "Authentication" section, enable Email/Password Authentication and Google Sign-In.

* Set up Firestore:
- In the Firebase Console, navigate to Firestore Database.
- Create a collection named notes.
- Download google-services.json or GoogleService-Info.plist:
- Follow the steps for your platform to download and add the respective config files to your Flutter project.

# Screens
1. Splash Screen - Displays the app logo and name for 2 seconds before navigating to the login screen.

2. Login Screen 
- Allows users to log in using their email/password or sign up for a new account.
- Supports switching between login and sign-up modes.
- Allows users to authenticate via Google OAuth.

3. Notes List Screen 
- Displays a list of notes with the ability to:
- Add new notes.
- Edit existing notes.
- Delete notes.
- Notes are retrieved in real-time from Firebase Firestore.

4. Add/Edit Notes Screen
- Provides a form to add or edit notes, including a title and content.
- Saves data to Firestore with a timestamp.

# Troubleshooting
* If you encounter any issues, here are some common solutions:

- Firebase Initialization Issues:

Make sure you have correctly added your Firebase configuration files (google-services.json or GoogleService-Info.plist) and initialized Firebase in the app.

Follow the official Firebase setup guide.

- Authentication Errors:

Ensure the Firebase Authentication method (Email/Password or Google Sign-In) is enabled in the Firebase Console.

Check if the email and password meet Firebase requirements (e.g., minimum password length).

- Firestore Errors:

Ensure that you have set the correct Firestore rules for read/write access.

If you are using Firestore on a real device, check if Firestore is initialized correctly.


# Notes:
* Make sure to replace the Firebase configuration details and other URLs with your actual repository and Firebase project info.
* You can also customize the features, future enhancements, or troubleshooting steps based on your app’s unique needs.
