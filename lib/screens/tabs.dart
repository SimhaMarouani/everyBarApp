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
    final deviceHeight = MediaQuery.of(context).size.height;
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
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    Color backgroundColor;
    if (brightness == Brightness.dark) {
      backgroundColor = const Color.fromARGB(255, 20, 20, 20);
    } else {
      backgroundColor = const Color.fromARGB(255, 230, 230, 230);
    }
    return Scaffold(
      backgroundColor: backgroundColor,
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.star),
              activeIcon: Icon(Icons.star),
              label: 'Favourites'),
          BottomNavigationBarItem(
              icon: Icon(Icons.wine_bar),
              activeIcon: Icon(Icons.wine_bar),
              label: 'Pubs'),
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              activeIcon: Icon(Icons.home),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              activeIcon: Icon(Icons.person),
              label: 'Profile'),
        ],
      ),
    );
  }
}
