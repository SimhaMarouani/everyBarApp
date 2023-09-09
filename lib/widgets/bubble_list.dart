import 'dart:math';

import 'package:flutter/material.dart';
import 'package:iBar/data/data.dart';
import 'package:iBar/models/business_model.dart';
import 'package:iBar/screens/business_home_page.dart';
import 'package:iBar/widgets/bubble.dart';

class GenerateBubblesResult {
  final List<Bubble> bubbles;
  final double totalWidth;

  GenerateBubblesResult(this.bubbles, this.totalWidth);
}

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

  GenerateBubblesResult generateBubbles(
    double width,
    double height,
  ) {
    List<double> heights = [height * 0.03, height * 0.06, height * 0.1];
    List<double> sizes = [width * 0.1, width * 0.15, width * 0.2];
    List<Bubble> businessesBubbles = [];
    Random random = Random();

    var totalWidth = 0.0;
    var currentHeight = 0.0;
    var maxSizeInColumn = 0.0;
    var lastInt = -1;

    for (int i = 0; i < businessList.length; i++) {
      int randomSizeInd = random.nextInt(sizes.length);
      while (randomSizeInd == lastInt) {
        randomSizeInd = random.nextInt(sizes.length);
      }
      lastInt = randomSizeInd;

      double randomSize = sizes[randomSizeInd];

      if (currentHeight + randomSize > height * 0.2) {
        totalWidth += maxSizeInColumn;
        currentHeight = 0.0;
        maxSizeInColumn = 0.0;
      }

      businessesBubbles.add(Bubble(
        name: businessList[i].name,
        left: totalWidth,
        top: currentHeight + heights[randomSizeInd],
        size: randomSize,
        onSelect: () {
          selectBusiness(context, businessList[i]);
        },
      ));

      currentHeight += randomSize * 2;
      maxSizeInColumn =
          maxSizeInColumn < randomSize ? randomSize : maxSizeInColumn;
    }

    return GenerateBubblesResult(businessesBubbles, totalWidth);
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final businessesBubbles = generateBubbles(deviceWidth, deviceHeight);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        height: deviceHeight * 0.3,
        width: businessesBubbles.totalWidth,
        child: Stack(
          children: <Widget>[
            for (var bub in businessesBubbles.bubbles) bub,
          ],
        ),
      ),
    );
  }
}
