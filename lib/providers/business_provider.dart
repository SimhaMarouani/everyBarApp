import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:iBar/data/data.dart';

import 'package:iBar/models/business_model.dart';

final businessesProvider = FutureProvider<List<Business>>((ref) async {
  try {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:5000/get_all_businesses'));

    if (response.statusCode == 200) {
      List<Business> businesses = businessesFromJson(response.body);
      return businesses;
    } else {
      return businessList;
    }
  } catch (error) {
    print('Error fetching businesses: $error');
    return businessList;
  }
});
