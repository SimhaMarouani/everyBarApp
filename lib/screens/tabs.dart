import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iBar/data/Headlines.dart';
import 'package:iBar/data/data.dart';
import 'package:iBar/providers/favourite_provider.dart';
import 'package:iBar/providers/language_provider.dart';
import 'package:iBar/screens/home_page.dart';
import 'package:iBar/widgets/main_drawer.dart';

class Tabs extends ConsumerStatefulWidget {
  const Tabs({super.key});

  @override
  ConsumerState<Tabs> createState() => _TabsState();
}

class _TabsState extends ConsumerState<Tabs> {
  int _selectedPageIndex = 0;

  void selectPage(int indexPage) {
    setState(() {
      _selectedPageIndex = indexPage;
    });
  }

  void _setScreen(String id) async {
    Navigator.of(context).pop();
    // todo: set screen
  }

  @override
  Widget build(BuildContext context) {
    final selectedLanguage = ref.watch(currentLanguageProvider);
    final selectedMap = selectedLanguageMap[selectedLanguage];
    Widget activePage = HomePage(
      availableBusinesses: businessList,
      onSelectScreen: _setScreen,
    );
    if (_selectedPageIndex == 1) {
      final favorit = ref.watch(favoriteBusinessProvider);
      activePage = HomePage(
        availableBusinesses: favorit,
        onSelectScreen: _setScreen,
      );
    }
    return Scaffold(
      body: activePage,
      drawer: MainDrawer(onSelectScreen: _setScreen),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).colorScheme.onSecondary,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0, // Adjust the margin as needed.
        elevation: 8.0, // Add elevation to the bottom app bar if desired.
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                selectPage(0); // Implement your navigation logic here.
              },
            ),
            IconButton(
              icon: const Icon(Icons.star_border),
              onPressed: () {
                selectPage(1); // Implement your navigation logic here.
              },
            ),
            const SizedBox(
                width: 48), // Add space in the middle for the rounded button.
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                selectPage(2); // Implement your navigation logic here.
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue, // Set the background color of the button.
        onPressed: () {
          // Implement your action when the middle button is pressed.
        },
        child: const Icon(Icons.home), // You can change the icon.
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
