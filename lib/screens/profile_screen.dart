import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iBar/screens/add_business_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user = FirebaseAuth.instance.currentUser;

  void goToAddBusinessScreen() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => AddBusinessScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          user != null ? user?.displayName ?? user!.email! : "Guest",
        ),
      ),
      body: ElevatedButton(
        onPressed: () => goToAddBusinessScreen(),
        child: const Text("Add A new business"),
      ),
    );
  }
}
