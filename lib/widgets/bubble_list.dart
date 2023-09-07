import 'dart:math';

import 'package:flutter/material.dart';
import 'package:iBar/data/data.dart';
import 'package:iBar/models/business_model.dart';
import 'package:iBar/screens/business_home_page.dart';
import 'package:iBar/widgets/bubble.dart';

class BubbleList extends StatefulWidget {
  const BubbleList({
    super.key,
    required this.businessList,
  });
  final List<Business> businessList;

  @override
  State<BubbleList> createState() => _BubbleListState();
}

class _BubbleListState extends State<BubbleList> {
  void selectBusiness(BuildContext context, Business business) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => BusinessHomePage(
          businessModel: business,
        ),
      ),
    );
  }

  List<Bubble> generateBubbles(
    double maxHeight,
    double minHeight,
    List<double> heights,
  ) {
    var totalWidth = 0;
    List<Bubble> businessesBubbles = [];
    Random random = Random();

    for (int i = 0; i < businessList.length; i++) {
      double randomHeight =
          random.nextDouble() * (maxHeight - minHeight) + minHeight;

      int randTomIndex = random.nextInt(heights.length);
      double randomTop = heights[randTomIndex];

      businessesBubbles.add(Bubble(
        name: businessList[i].name,
        left: totalWidth.toDouble(),
        top: randomTop,
        size: randomHeight,
        onSelect: () {
          selectBusiness(context, businessList[i]);
        },
      ));
      totalWidth += randomHeight.toInt();
    }

    return businessesBubbles;
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    List<Bubble> businessesBubbles = generateBubbles(
      deviceHeight * 0.15,
      deviceHeight * 0.05,
      [deviceHeight * 0.02, deviceHeight * 0.05, deviceHeight * 0.1],
    );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        height: deviceHeight * 0.3,
        width: deviceWidth * 1.5, // Adjust the width as needed
        child: Stack(
          children: <Widget>[
            for (var bub in businessesBubbles) bub,
          ],
        ),
      ),
    );
  }
}
