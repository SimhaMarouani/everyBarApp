import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iBar/screens/sign_screen.dart';
import 'package:iBar/screens/tabs.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Show a loading indicator.
          } else if (snapshot.hasData) {
            return const Tabs(); // User is already signed in.
          } else {
            return SignScreen(); // Show the sign-in screen.
          }
        },
      ),
    );
  }
}
