import 'package:flutter/material.dart';
import 'package:iBar/models/business_model.dart';

class BusinesListItem extends StatelessWidget {
  const BusinesListItem({
    super.key,
    required this.category,
    required this.onSelect,
  });

  final Business category;
  final void Function() onSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, top: 10),
      child: InkWell(
        onTap: onSelect,
        splashColor: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: EdgeInsets.all(
              (MediaQuery.of(context).size.width * 0.12).toDouble()),
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
            ),
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
          child: Text(
            category.name,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Theme.of(context).colorScheme.background),
          ),
        ),
      ),
    );
  }
}
