import 'package:flutter/material.dart';
import 'package:iBar/data/Headlines.dart';
import 'package:iBar/models/business_model.dart';
import 'package:iBar/providers/language_provider.dart';
import 'package:iBar/screens/search_screen.dart';
import 'package:iBar/widgets/home_search_bar.dart';
import 'package:iBar/widgets/business_list_generator.dart';
import 'package:iBar/widgets/main_drawer.dart';
import 'package:iBar/widgets/search_pads.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({
    super.key,
    required this.availableBusinesses,
    required this.onSelectScreen,
  });

  final List<Business> availableBusinesses;
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

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void onLanguageSelected(String language) {
    ref.read(currentLanguageProvider.notifier).setLanguage(language);
  }

  @override
  Widget build(BuildContext context) {
    List<String> languageOptions = [
      'English',
      'Hebrew',
    ];
    final selectedLanguage = ref.watch(currentLanguageProvider);
    final selectedMap = selectedLanguageMap[selectedLanguage];
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceStatusBar = MediaQuery.of(context).padding.top;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: deviceStatusBar),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DrawerButton(
                      onPressed: () => Scaffold.of(context).openDrawer()),
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      'EveryBar',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: deviceWidth * 0.09,
                          fontWeight: FontWeight.bold),
                    ),
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
            ),
          ),
          SliverAppBar(
            forceElevated: true,
            pinned: true,
            title: FakeSearchBar(onPress: onSearchPress),
            expandedHeight: deviceHeight * 0.2, // Set as needed
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                  padding: EdgeInsets.only(
                    top: deviceHeight * 0.1,
                  ),
                  child: SearchPads(animationController: _animationController)),
            ),
          ),
          SliverAnimatedList(
            initialItemCount: 2,
            itemBuilder: (context, index, animation) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assests/sale-2.png",
                        width: deviceWidth * 0.1,
                        height: deviceHeight * 0.1,
                      ),
                      Text(
                        selectedMap?["sales"] ?? "   Sales:",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  BusinessList(
                    animationController: _animationController,
                    isList: true,
                    bList: widget.availableBusinesses,
                    isSearching: true,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Image.asset(
                      "assests/light.png",
                      width: deviceWidth * 0.1,
                      height: deviceHeight * 0.1,
                    ),
                    Text(
                      textAlign: TextAlign.start,
                      selectedMap?["in area"] ?? "   In Your Area:",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
                  BusinessList(
                    animationController: _animationController,
                    isList: true,
                    bList: widget.availableBusinesses,
                    isSearching: true,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
