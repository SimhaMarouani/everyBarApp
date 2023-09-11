import 'package:flutter/material.dart';
import 'package:iBar/data/data.dart';
import 'package:iBar/models/business_model.dart';
import 'package:iBar/widgets/business_list_vertical.dart';

class DrinkScreen extends StatefulWidget {
  const DrinkScreen({
    super.key,
    required this.availableBusinesses,
  });
  final List<Business> availableBusinesses;

  @override
  State<DrinkScreen> createState() => _DrinkScreenState();
}

class _DrinkScreenState extends State<DrinkScreen> {
  @override
  Widget build(BuildContext context) {
    return BusinessListV(bList: businessList);
  }
}
