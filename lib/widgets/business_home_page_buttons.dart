import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iBar/models/business_model.dart';

class BusinessPageButtons extends ConsumerWidget {
  const BusinessPageButtons({
    super.key,
    required this.business,
  });

  final Business business;

  List<Container> createButtons(BuildContext context) {
    List<Container> iconsList = [];
    iconsList.add(createButton(business.location, context, Icons.map));
    if (business.phone != null) {
      iconsList.add(createButton(business.phone, context, Icons.phone));
    }
    if (business.menu != null) {
      iconsList.add(createButton(business.phone, context, Icons.menu_book));
    }
    return iconsList;
  }

  Container createButton(var param, BuildContext context, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).hintColor,
      ),
      child: IconButton(
        onPressed: () {},
        icon: Icon(icon),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Container> buttonsList = createButtons(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children:
          buttonsList.isNotEmpty ? [for (var wid in buttonsList) wid] : [],
    );
  }
}
