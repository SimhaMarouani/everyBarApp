import 'package:flutter/material.dart';
import 'package:iBar/models/business_model.dart';
import 'package:iBar/widgets/business_list_generator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.availableBusinesses});

  final List<Business> availableBusinesses;

  @override
  State<HomePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final FocusNode _focusNode = FocusNode();
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

  @override
  void dispose() {
    _animationController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: TextFormField(
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  focusNode: _focusNode,
                  onTap: () {
                    // Set focus on tap
                    _focusNode.requestFocus();
                  },
                  onTapOutside: (event) => _focusNode.unfocus(),
                  decoration: InputDecoration(
                    labelText: 'Tap to search..',
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    labelStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    border: InputBorder.none,
                    alignLabelWithHint: true,
                    icon: Image.asset(
                      'assests/beer.png',
                      width: deviceWidth * 0.1,
                      height: deviceHeight * 0.1,
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
                onPressed: () {
                  // Perform search action here
                },
                child: const Icon(Icons.search),
              ),
            ],
          ),
          expandedHeight: deviceHeight * 0.2, // Set as needed
          flexibleSpace: FlexibleSpaceBar(
            background: Padding(
              padding: EdgeInsets.only(
                top: deviceHeight * 0.1,
                left: deviceWidth * 0.35,
              ),
              child: Text(
                'Logo Here',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              // Build your scrollable content here
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
                    isList: false,
                    bList: widget.availableBusinesses,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
