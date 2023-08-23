import 'package:flutter/material.dart';
import 'package:school_info_app/models/business_model.dart';
import 'package:school_info_app/data/data.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:school_info_app/widgets/business_list.dart';

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
      padding: const EdgeInsets.only(left: 10, top: 10),
      child: Column(children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: TextFormField(
                focusNode: _focusNode,
                onTapOutside: (event) => _focusNode.unfocus(),
                decoration: const InputDecoration(
                    labelText: 'Tap to search..',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    labelStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    alignLabelWithHint: true,
                    suffixIcon: Icon(Icons.wine_bar)),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                  backgroundColor: Theme.of(context).colorScheme.background),
              onPressed: () {},
              child: const Icon(Icons.search),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.1),
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Text(
            textAlign: TextAlign.start,
            "Sales:",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ]),
        listPubs,
      ]),
    );
  }
}
