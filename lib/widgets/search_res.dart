import 'package:flutter/material.dart';
import 'package:iBar/models/business_model.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({
    super.key,
    required this.businessList,
  });
  final List<Business> businessList;

  @override
  Widget build(BuildContext context) {
    // var deviceWidth = MediaQuery.of(context).size.width;

    List<Widget> stepsWidgets = [];
    for (int i = 0; i < businessList.length; i++) {
      final step = businessList[i];
      Widget stepWidget = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white)),
              child: Text(
                '${i + 1}. ${step.name}',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            ),
          ),
          const SizedBox(height: 33),
        ],
      );
      stepsWidgets.add(stepWidget);
    }

    return Column(
      children: [
        for (final wid in stepsWidgets) wid,
      ],
    );
  }
}
