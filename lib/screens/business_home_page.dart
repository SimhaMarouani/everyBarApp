import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iBar/models/business_model.dart';
import 'package:iBar/providers/favourite_provider.dart';

class BusinessHomePage extends ConsumerWidget {
  const BusinessHomePage({
    super.key,
    required this.businessModel,
  });
  final Business businessModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteBusinesses = ref.watch(favoriteBusinessProvider);
    final isFav = favoriteBusinesses.contains(businessModel);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              final wasAdded = ref
                  .read(favoriteBusinessProvider.notifier)
                  .toggleMealFavoriteStatus(businessModel);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(wasAdded ? 'Marked As Favorites' : 'Removed')));
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
              ),
            ),
          ),
        ],
        title: Text(
          businessModel.name,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.height * 0.045,
              ),
              child: Hero(
                tag: businessModel.name,
                child: Image.asset(
                  "assests/home.png",
                  height: MediaQuery.of(context).size.height * 0.4,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
