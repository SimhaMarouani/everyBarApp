import 'package:flutter/material.dart';
import 'package:iBar/models/business_model.dart';
import 'package:iBar/screens/search_screen.dart';
import 'package:iBar/widgets/home_search_bar.dart';
import 'package:iBar/widgets/business_list_generator.dart';
import 'package:iBar/widgets/search_pads.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.availableBusinesses,
    required this.onSelectScreen,
  });

  final List<Business> availableBusinesses;
  final void Function(String identifier) onSelectScreen;

  @override
  State<HomePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomePage>
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

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Positioned.fill(
          child: Opacity(
            opacity: 0.1,
            child: Image.asset(
              "assests/background.jpg",
              fit: BoxFit.fill,
            ),
          ),
        ),
        CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: deviceHeight * 0.1),
                    child: Center(
                      child: Text(
                        'EveryBar',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: deviceWidth * 0.1,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
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
                    child:
                        SearchPads(animationController: _animationController)),
              ),
            ),
            SliverAnimatedList(
              initialItemCount: 1,
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
                          textAlign: TextAlign.start,
                          "   Sales:",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
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
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Image.asset(
                        "assests/light.png",
                        width: deviceWidth * 0.1,
                        height: deviceHeight * 0.1,
                      ),
                      Text(
                        textAlign: TextAlign.start,
                        "   In your area:",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
                    BusinessList(
                      animationController: _animationController,
                      isList: true,
                      bList: widget.availableBusinesses,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
