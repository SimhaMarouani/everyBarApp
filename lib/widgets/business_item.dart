import 'package:flutter/material.dart';
import 'package:iBar/models/business_model.dart';

class BusinesListItem extends StatelessWidget {
  const BusinesListItem({
    super.key,
    required this.businessItem,
    required this.onSelect,
  });

  final Business businessItem;
  final void Function() onSelect;

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      width: deviceWidth * 0.4,
      height: deviceHeight * 0.2,
      margin: const EdgeInsets.only(left: 10, top: 0),
      child: InkWell(
        onTap: onSelect,
        splashColor: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: deviceWidth * 0.4,
          height: deviceHeight * 0.2,
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.secondary,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: LayoutBuilder(builder: (context, constraints) {
            double textFontSize = 30.0; // Adjust the font size as needed
            TextSpan textSpan = TextSpan(
              text: businessItem.name,
              style: TextStyle(
                fontSize: textFontSize,
                color: Theme.of(context).colorScheme.secondary,
              ),
            );

            TextPainter textPainter = TextPainter(
              text: textSpan,
              textDirection: TextDirection.ltr,
            );
            textPainter.layout();

            double textWidth = textPainter.width;

            return Stack(
              fit: StackFit.loose,
              children: [
                Image.asset("assests/home.png"),
                Positioned(
                  left: constraints.maxWidth * 0.5 - textWidth * 0.5,
                  top: constraints.minHeight * 0.01,
                  child: Text(
                    businessItem.name,
                    style: TextStyle(
                      fontSize: 30,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
