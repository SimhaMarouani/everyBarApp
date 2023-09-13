import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    super.key,
    required this.onSelectScreen,
    required this.onSignOut,
  });

  final void Function(String identifier) onSelectScreen;
  final void Function() onSignOut;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        LayoutBuilder(
          builder: (context, constraints) {
            double textFontSize = 30.0; // Adjust the font size as needed
            TextSpan textSpan = TextSpan(
              text: "Profile",
              style: TextStyle(
                fontSize: textFontSize,
                color: Theme.of(context).colorScheme.secondary,
              ),
            );

            TextPainter textPainter = TextPainter(
              text: textSpan,
              textDirection: TextDirection.ltr,
            );
            textPainter.layout();

            double textWidth = textPainter.width;
            return DrawerHeader(
              padding: EdgeInsets.only(
                top: constraints.minHeight,
                left: constraints.maxWidth * 0.5 - textWidth,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.onPrimary.withOpacity(0.8)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(children: [
                Icon(
                  Icons.person,
                  size: 48,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 18),
                Text(
                  'Profile',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                )
              ]),
            );
          },
        ),
        ListTile(
          leading: Icon(
            Icons.home,
            size: 26,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          title: Text('Home',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 24,
                  )),
          onTap: () {
            onSelectScreen('meals');
          },
        ),
        ListTile(
          leading: Icon(
            Icons.settings,
            size: 26,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          title: Text('Settings',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 24,
                  )),
          onTap: () {
            onSelectScreen('filters');
          },
        ),
        ListTile(
          leading: Icon(
            Icons.person,
            size: 26,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          title: Text('Sign In',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 24,
                  )),
          onTap: () {
            onSelectScreen('profile');
          },
        ),
        ListTile(
          leading: Icon(
            Icons.exit_to_app,
            size: 26,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          title: Text('Sign Out',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 24,
                  )),
          onTap: () {
            onSignOut();
          },
        ),
      ]),
    );
  }
}
