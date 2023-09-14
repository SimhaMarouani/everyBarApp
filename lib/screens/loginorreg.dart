import 'package:flutter/material.dart';
import 'package:iBar/screens/register_page.dart';
import 'package:iBar/screens/sign_screen.dart';

class LoginOrReg extends StatefulWidget {
  const LoginOrReg({super.key});

  @override
  State<LoginOrReg> createState() => _LoginOrRegState();
}

class _LoginOrRegState extends State<LoginOrReg> {
  bool showLoginPage = true;

  void togglePage() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showLoginPage
        ? SignScreen(onTap: togglePage)
        : RegisterPage(
            onTap: togglePage,
          );
  }
}
