import 'package:flutter/material.dart';
import 'package:iBar/models/business_model.dart';
import 'package:iBar/widgets/search_bar.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({
    super.key,
    required this.businessList,
    required this.searchBar,
  });
  final List<Business> businessList;
  final MySearchBar searchBar;

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
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
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          forceElevated: true,
          pinned: true,
          title: searchBar,
          expandedHeight: deviceHeight * 0.2,
        ),
        SliverAnimatedList(
          initialItemCount: 2,
          itemBuilder: (context, index, animation) {
            return Column(
              children: [
                for (final wid in stepsWidgets) wid,
              ],
            );
          },
        )
      ],
    );
  }
}
