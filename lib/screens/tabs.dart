import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iBar/providers/filterd_business_provider.dart';
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
    //final availableSales = ref.watch(filteredMealsProider);
    final businesses = ref.watch(filteredBusinessProider);
    Widget activePage = HomePage(
      availableBusinesses: businesses,
      onSelectScreen: _setScreen,
    );
    return Scaffold(
      body: activePage,
      drawer: MainDrawer(onSelectScreen: _setScreen),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        onTap: selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              activeIcon: Icon(Icons.home_filled),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.star_border),
              activeIcon: Icon(Icons.star),
              label: 'Favourites'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              activeIcon: Icon(Icons.person_2_rounded),
              label: 'Profile'),
        ],
      ),
    );
  }
}
