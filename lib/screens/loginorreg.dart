import 'package:flutter/material.dart';
import 'package:iBar/screens/register_page.dart';
import 'package:iBar/screens/sign_screen.dart';
import 'package:iBar/screens/tabs.dart';

class LoginOrReg extends StatefulWidget {
  const LoginOrReg({super.key});

  @override
  State<LoginOrReg> createState() => _LoginOrRegState();
}

class _LoginOrRegState extends State<LoginOrReg> {
  bool showLoginPage = true;
  bool guest = false;

  void togglePage() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  void continueAsUser() {
    setState(() {
      guest = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (guest) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Tabs()),
        );
      });
      return SizedBox();
    }
    return showLoginPage
        ? SignScreen(
            onTap: togglePage,
            onGuestTap: continueAsUser,
          )
        : RegisterPage(
            onTap: togglePage,
            onGuestTap: continueAsUser,
          );
  }
}
