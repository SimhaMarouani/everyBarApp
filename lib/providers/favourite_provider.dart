import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:iBar/models/business_model.dart';

class FavoriteMealNotifier extends StateNotifier<List<Business>> {
  FavoriteMealNotifier() : super([]);

  bool toggleMealFavoriteStatus(Business busi) {
    final busiIsFavorite = state.contains(busi);

    if (busiIsFavorite) {
      state = state.where((m) => m.name != m.name).toList();
      return false;
    } else {
      state = [...state, busi];
      return true;
    }
  }
}

final favoriteBusinessProvider =
    StateNotifierProvider<FavoriteMealNotifier, List<Business>>((ref) {
  return FavoriteMealNotifier();
});
