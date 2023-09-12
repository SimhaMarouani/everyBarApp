import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iBar/models/business_model.dart';

class BusinessPageTexts extends ConsumerWidget {
  const BusinessPageTexts({
    super.key,
    required this.business,
  });

  final Business business;

  List<Widget> createTexts(BuildContext context) {
    List<Widget> texts = [];
    texts.add(createText(business.location, context, "כתובת: ", ""));
    texts.add(createText(business.openTime, context, "שעות פתיחה: ",
        " - ${business.closedTime}"));
      if (business.hasHappyHour) {
      texts.add(createText("Happy Hour", context, "", ""));
    } else {
      texts.add(createText("No happy hour", context, "", ""));
    }
      if (business.isKosher) {
        texts.add(createText("כשר", context, "", ""));
      } else {
        texts.add(createText("לא כשר", context, "", ""));
      }
      return texts;
  }

  Widget createText(
      String param, BuildContext context, String preText, String midText) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Text(
          preText + param + midText,
          textAlign: TextAlign.right,
          style: TextStyle(
            color: Colors.black,
            fontSize: deviceWidth * 0.05,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Widget> textsList = createTexts(context);
    return Column(
      children: textsList.isNotEmpty ? textsList : [],
    );
  }
}
