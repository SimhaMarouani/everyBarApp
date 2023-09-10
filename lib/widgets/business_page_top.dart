import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iBar/models/business_model.dart';
import 'package:iBar/providers/favourite_provider.dart';

class BusinessPageTop extends ConsumerWidget {
  const BusinessPageTop({
    Key? key,
    required this.business,
  }) : super(key: key);

  final Business business;

  List<IconButton> createButtons(
      BuildContext context, bool isFav, WidgetRef ref) {
    return [
      IconButton(
        icon: const Icon(Icons.arrow_back),
        color: Colors.white,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      IconButton(
        onPressed: () {
          final wasAdded = ref
              .read(favoriteBusinessProvider.notifier)
              .toggleMealFavoriteStatus(business);
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(wasAdded ? 'Marked As Favorites' : 'Removed'),
          ));
        },
        icon: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return RotationTransition(
              turns: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
              child: child,
            );
          },
          child: Icon(
            isFav ? Icons.star : Icons.star_border,
            key: ValueKey(isFav),
            color: Colors.white,
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteBusinesses = ref.watch(favoriteBusinessProvider);
    final isFav = favoriteBusinesses.contains(business);
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    List<IconButton> buttonsList = createButtons(context, isFav, ref);
    return Padding(
      padding: EdgeInsets.only(
          top: deviceHeight * 0.05,
          left: deviceHeight * 0.02,
          right: deviceWidth * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:
            buttonsList.isNotEmpty ? [for (var wid in buttonsList) wid] : [],
      ),
    );
  }
}
