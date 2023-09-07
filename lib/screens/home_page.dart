import 'package:flutter/material.dart';
import 'package:iBar/data/Headlines.dart';
import 'package:iBar/models/business_model.dart';
import 'package:iBar/providers/language_provider.dart';
import 'package:iBar/screens/search_screen.dart';
import 'package:iBar/widgets/appbar_list.dart';
import 'package:iBar/widgets/business_list_generator.dart';
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

  void _restartAnimation() {
    _animationController.reset();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    List<String> languageOptions = [
      'English',
      'Hebrew',
    ];
    final selectedLanguage = ref.watch(currentLanguageProvider);
    final selectedMap = selectedLanguageMap[selectedLanguage];
    var Align = selectedLanguage == 'English'
        ? Alignment.centerRight
        : Alignment.centerLeft;
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
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      SizedBox(
                        width: deviceWidth,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ListWidget(),
                            ListWidget(),
                            ListWidget(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverAnimatedList(
              initialItemCount: 2,
              itemBuilder: (context, index, animation) {
                return Padding(
                  padding: EdgeInsets.only(top: deviceHeight * 0.01),
                  child: Column(
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
                            selectedMap?["in area"] ?? "   In Your Area:",
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
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assests/light.png",
                              width: deviceWidth * 0.1,
                              height: deviceHeight * 0.1,
                            ),
                            Text(
                              textAlign: TextAlign.start,
                              selectedMap?["favor"] ?? "   Favorites:",
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
