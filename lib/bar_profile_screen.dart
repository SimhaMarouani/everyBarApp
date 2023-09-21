import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BarProfile extends ConsumerWidget {
  const BarProfile({
    Key? key,
  }) : super(key: key);

  List<WidgetSpan> generateTextSpans(BuildContext context) {
    final List<String> menuItems = ['Favorites', 'Messages', 'Reviews'];

    return menuItems.map((text) {
      return WidgetSpan(
        alignment: PlaceholderAlignment.middle,
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Text(
            text,
            style: TextStyle(
              color: Theme.of(context).secondaryHeaderColor,
            ),
            // Add an onTap handler to open the link when tapped
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Container(
      width: deviceWidth,
      height: 50,
      decoration: BoxDecoration(color: Color.fromARGB(255, 240, 240, 240)),
      child: Center(
        child: RichText(
          text: TextSpan(
            children: generateTextSpans(context), // Use the generated TextSpans
          ),
        ),
      ),
    );
  }
}
