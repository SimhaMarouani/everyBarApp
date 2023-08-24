import 'package:iBar/data/data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final availbusiProvider = Provider((ref) {
  return businessList;
});
