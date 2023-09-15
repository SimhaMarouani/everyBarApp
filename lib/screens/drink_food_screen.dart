import 'package:flutter/material.dart';
import 'package:iBar/data/data.dart';
import 'package:iBar/models/business_model.dart';
import 'package:iBar/widgets/lists/business_list_vertical.dart';

class DrinkFoodScreen extends StatefulWidget {
  const DrinkFoodScreen({
    super.key,
    required this.availableBusinesses,
  });
  final List<Business> availableBusinesses;

  @override
  State<DrinkFoodScreen> createState() => _DrinkFoodScreenState();
}

class _DrinkFoodScreenState extends State<DrinkFoodScreen> {
  @override
  Widget build(BuildContext context) {
    return const BusinessListV(bList: businessList);
  }
}
