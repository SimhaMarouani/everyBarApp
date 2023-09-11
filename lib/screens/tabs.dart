import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iBar/data/data.dart';
import 'package:iBar/providers/language_provider.dart';
import 'package:iBar/screens/drink_food_screen.dart';
import 'package:iBar/screens/drink_screen.dart';
import 'package:iBar/screens/home_page.dart';
import 'package:iBar/screens/profile_screen.dart';
import 'package:iBar/screens/search_screen.dart';
import 'package:iBar/widgets/main_drawer.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Tabs extends ConsumerStatefulWidget {
  const Tabs({super.key});

  @override
  ConsumerState<Tabs> createState() => _TabsState();
}

class _TabsState extends ConsumerState<Tabs> with TickerProviderStateMixin {
  int _selectedPageIndex = 2;
  late AnimationController _animationController;
  late Animation<double> _animation;

  String str = "";
  void selectPage(int indexPage) {
    setState(() {
      _selectedPageIndex = indexPage;
    });
    _animationController.reset();
    _animationController.forward();
  }

  void _setScreen(String id) async {}

  List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700), // Adjust animation duration
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.forward();

    _pages = [
      DrinkFoodScreen(),
      DrinkScreen(),
      HomePage(
        availableBusinesses: businessList,
        onSelectScreen: _setScreen,
      ),
      SearchScreen(
        passStr: str,
      ),
      ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final selectedLanguage = ref.watch(currentLanguageProvider);

    Brightness brightness = MediaQuery.of(context).platformBrightness;
    Color backgroundColor;
    if (brightness == Brightness.dark) {
      backgroundColor = const Color.fromARGB(255, 20, 20, 20);
    } else {
      backgroundColor = const Color.fromARGB(255, 230, 230, 230);
    }
    return Scaffold(
      // drawer: MainDrawer(onSelectScreen: _setScreen),
      backgroundColor: backgroundColor,
      body: AnimatedSwitcher(
        duration: Duration(seconds: 1), // Adjust animation duration
        child: FadeTransition(
          opacity: _animation,
          child: _pages[_selectedPageIndex],
        ),
        transitionBuilder: (child, animation) {
          return ScaleTransition(
            scale: animation,
            child: child,
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            activeIcon: Icon(Icons.fastfood),
            label: 'Drink & Food',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wine_bar),
            activeIcon: Icon(Icons.wine_bar),
            label: 'Drink',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            activeIcon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
