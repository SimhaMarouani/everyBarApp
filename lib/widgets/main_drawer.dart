import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iBar/screens/loginorreg.dart';
import 'package:iBar/screens/register_page.dart';
import 'package:iBar/widgets/buttons/drawer_button.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    super.key,
    required this.onSelectScreen,
    required this.onSignOut,
  });

  final void Function(String identifier) onSelectScreen;
  final void Function() onSignOut;

  void openRegisterPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => LoginOrReg(
        showLoginPage: false,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Drawer(
      width: deviceWidth * 0.525,
      child: DrawerHeader(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).hintColor,
              Theme.of(context).highlightColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: deviceHeight * 0.15,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.person_2_outlined,
                    size: deviceWidth * 0.1,
                  ),
                  FittedBox(
                    fit: BoxFit.cover,
                    child: Text(
                      user != null && user.emailVerified
                          ? user.email.toString()
                          : "Guest",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width * 0.08,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: deviceHeight * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "New Here? ",
                        style: TextStyle(color: Colors.black),
                      ),
                      GestureDetector(
                        onTap: () {
                          openRegisterPage(context);
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.blue),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            const Divider(
              thickness: 0.5,
              color: Colors.black,
            ),
            MyDrawerButton(
              TextToShow: 'Settings',
              icon: Icon(
                Icons.settings,
                size: 26,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              onTap: () {
                Scaffold.of(context).closeDrawer();
              },
            ),
            MyDrawerButton(
              TextToShow: 'Sign In',
              icon: Icon(
                Icons.person,
                size: 26,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              onTap: () {
                Scaffold.of(context).closeDrawer();
                onSelectScreen('profile');
              },
            ),
            MyDrawerButton(
              TextToShow: 'Sign Out',
              icon: Icon(
                Icons.exit_to_app,
                size: 26,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              onTap: () {
                Scaffold.of(context).closeDrawer();
                onSignOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
