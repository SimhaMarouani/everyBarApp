import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iBar/models/business_model.dart';

class FilterdBusiNotifier extends StateNotifier<List<Business>> {
  FilterdBusiNotifier() : super([]);

  bool toggleMealFavoriteStatus(Business busi, String condition) {
    final busiIsFavorite = state.contains(busi);

    if (busiIsFavorite) {
      state = state.where((m) => m.name != busi.name).toList();
      return false;
    } else {
      if (busi.hasFood) {
        // Only add if the business has food
        state = [...state, busi];
        return true;
      } else {
        return false; // Business doesn't have food, don't add to favorites
      }
    }
  }
}

final hasFoodBusinessProvider =
    StateNotifierProvider<FilterdBusiNotifier, List<Business>>((ref) {
  return FilterdBusiNotifier();
});
