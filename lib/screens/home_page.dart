import 'package:flutter/material.dart';
import 'package:iBar/models/business_model.dart';
import 'package:iBar/data/data.dart';
import 'package:iBar/widgets/business_list.dart';

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

    Widget listPubs = AnimatedBuilder(
      animation: _animationController,
      child: SizedBox(
        height: deviceHeight * 0.25,
        child: ListView.builder(
          padding: const EdgeInsets.only(top: 10),
          itemCount: businessList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => BusinesListItem(
            category: businessList[index],
            onSelect: () {},
          ),
        ),
      ),
      builder: (ctx, child) => SlideTransition(
        position: Tween(
          begin: const Offset(0.7, 0),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
              parent: _animationController, curve: Curves.easeInOut),
        ),
        child: child,
      ),
    );
    return Padding(
      padding: EdgeInsets.only(
          left: deviceWidth * 0.03,
          top: deviceHeight * 0.03,
          right: deviceWidth * 0.03),
      child: SingleChildScrollView(
        child: Column(children: [
          Container(
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              color: Theme.of(context)
                  .colorScheme
                  .secondary, // Remove the background color
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextFormField(
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    focusNode: _focusNode,
                    onTapOutside: (event) => _focusNode.unfocus(),
                    decoration: InputDecoration(
                        labelText: 'Tap to search..',
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 0),
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
                        )),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(10),
                      backgroundColor: Theme.of(context).colorScheme.secondary),
                  onPressed: () {},
                  child: const Icon(Icons.search),
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Image.asset(
              "assests/sale-2.png",
              width: deviceWidth * 0.1,
              height: deviceHeight * 0.1,
            ),
            const SizedBox(width: 10),
            Text(
              textAlign: TextAlign.start,
              "Sales:",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
          listPubs,
          SizedBox(height: deviceHeight * 0.1),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Image.asset(
              "assests/light.png",
              width: deviceWidth * 0.1,
              height: deviceHeight * 0.1,
            ),
            const SizedBox(width: 10),
            Text(
              textAlign: TextAlign.start,
              "In your area:",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
          listPubs,
        ]),
      ),
    );
  }
}
