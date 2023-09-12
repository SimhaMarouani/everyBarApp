import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iBar/models/business_model.dart';

class VerticalListTexts extends ConsumerWidget {
  const VerticalListTexts({
    super.key,
    required this.business,
  });

  final Business business;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.only(
            right: deviceWidth * 0.35 * 0.1,
            top: deviceHeight * 0.25 * 0.4 * 0.1,
          ),
          child: Text(
            business.name,
            style: TextStyle(
                fontSize: deviceWidth * 0.045, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: deviceWidth * 0.35 * 0.1),
          child: Text(
            business.location.toString(),
            style: TextStyle(
                fontSize: deviceWidth * 0.035, fontWeight: FontWeight.w400),
          ),
        )
      ],
    );
  }
}
