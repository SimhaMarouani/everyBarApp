import 'package:flutter/material.dart';
import 'package:iBar/data/Headlines.dart';
import 'package:iBar/data/data.dart';
import 'package:iBar/providers/business_provider.dart';
import 'package:iBar/providers/language_provider.dart';
import 'package:iBar/screens/add_business_screen.dart';
import 'package:iBar/screens/drink_food_screen.dart';
import 'package:iBar/screens/drink_screen.dart';
import 'package:iBar/screens/profile_screen.dart';
import 'package:iBar/screens/search_screen.dart';
import 'package:iBar/widgets/lists/bubble_list.dart';
import 'package:iBar/widgets/lists/business_list_horizontal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({
    super.key,
    required this.onSelectScreen,
  });

  final void Function(String identifier) onSelectScreen;

  @override
  ConsumerState<HomePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends ConsumerState<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 850),
      lowerBound: 0,
      upperBound: 1,
    );

    _animationController.forward();
  }

  void onSearchPress(String str) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => SearchScreen(
          passStr: str,
        ),
      ),
    );
  }

  void onProfilePress(String str) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => const ProfileScreen(),
      ),
    );
  }

  void onDrinkPress(String str) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => const DrinkScreen(
          availableBusinesses: businessList,
        ),
      ),
    );
  }

  void onDrinkFoodPress(String str) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => const AddBusinessScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void onLanguageSelected(String language) {
    ref.read(currentLanguageProvider.notifier).setLanguage(language);
  }

  void _restartAnimation() {
    _animationController.reset();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final businessData = ref.watch(businessesProvider);
    List<String> languageOptions = [
      'English',
      'Hebrew',
    ];
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Consumer(
      builder: (context, ref, child) {
        final selectedLanguage = ref.watch(currentLanguageProvider);
        final selectedMap = selectedLanguageMap[selectedLanguage];
        _restartAnimation();
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              pinned: true,
              backgroundColor: Theme.of(context).hintColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'EveryBar',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: deviceWidth * 0.1,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Tangerine'),
                  ),
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.language), // Language icon
                    onSelected: onLanguageSelected,
                    itemBuilder: (BuildContext context) {
                      return languageOptions.map((String language) {
                        return PopupMenuItem<String>(
                          value: language,
                          child: Text(
                            language,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                        );
                      }).toList();
                    },
                  ),
                ],
              ),
              expandedHeight: deviceHeight * 0.3,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: EdgeInsets.only(top: deviceHeight * 0.10),
                  child: const BubbleList(businessList: businessList),
                ),
              ),
            ),
            SliverAnimatedList(
              initialItemCount: 2,
              itemBuilder: (context, index, animation) {
                return Padding(
                  padding: EdgeInsets.only(top: deviceHeight * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: deviceWidth * 0.015),
                        child: Text(
                          selectedMap?["in area"] ?? "   In Your Area",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: deviceWidth * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      BusinessListH(
                        animationController: _animationController,
                        isList: true,
                        bList: businessData.maybeWhen(
                          data: (businesses) => businesses,
                          orElse: () => [],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: deviceHeight * 0.05, left: deviceWidth * 0.05),
                        child: Text(
                          selectedMap?["favor"] ?? "   Favorites:",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: deviceWidth * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      BusinessListH(
                        animationController: _animationController,
                        isList: true,
                        bList: businessData.maybeWhen(
                          data: (businesses) => businesses,
                          orElse: () => [],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
