import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:iBar/models/business_model.dart';

class FavoriteBusiNotifier extends StateNotifier<List<Business>> {
  FavoriteBusiNotifier() : super([]);

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
    StateNotifierProvider<FavoriteBusiNotifier, List<Business>>((ref) {
  return FavoriteBusiNotifier();
});
