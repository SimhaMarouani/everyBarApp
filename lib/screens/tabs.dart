import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:school_info_app/providers/filterd_business_provider.dart';
import 'package:school_info_app/screens/home_page.dart';

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

  void setScreen(String id) async {
    Navigator.of(context).pop();
    // todo: set screen
  }

  @override
  Widget build(BuildContext context) {
    //final availableSales = ref.watch(filteredMealsProider);
    final businesses = ref.watch(filteredBusinessProider);
    var activePageTitle = 'HomePage';
    Widget activePage = HomePage(
      availableBusinesses: businesses,
    );
    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favourites'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
