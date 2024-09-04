import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iBar/bar_profile_screen.dart';
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
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              user != null ? user?.displayName ?? user!.email! : "Guest",
              style: TextStyle(
                color: Colors.white,
                fontSize: deviceWidth * 0.045,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              user != null ? user!.email! : "",
              style: TextStyle(
                color: Colors.white,
                fontSize: deviceWidth * 0.035,
              ),
            ),
          ],
        ),
        toolbarHeight: deviceHeight * 0.1,
        backgroundColor: Theme.of(context).hintColor,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: BarProfile(),
          ),
          Expanded(
              child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
              child: ElevatedButton(
                onPressed: () => goToAddBusinessScreen(),
                child: const Text("Add a new business"),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
