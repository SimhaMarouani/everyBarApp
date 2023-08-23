import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:school_info_app/providers/business_provider.dart';

enum Filter { happyHour }

class FlitersNotifier extends StateNotifier<Map<Filter, bool>> {
  FlitersNotifier()
      : super({
          Filter.happyHour: false,
        });

  void setFilter(Filter filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }

  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }
}

final filtersProvider =
    StateNotifierProvider<FlitersNotifier, Map<Filter, bool>>(
  (ref) => FlitersNotifier(),
);

final filteredBusinessProider = Provider((ref) {
  final businesses = ref.watch(availbusiProvider);
  final activeFilters = ref.watch(filtersProvider);
  return businesses.where((business) {
    if (activeFilters[Filter.happyHour]! && !business.hasHappyHour) {
      return false;
    }
    return true;
  }).toList();
});
