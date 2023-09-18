import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:iBar/models/business_model.dart';

class BusinesListItem extends StatelessWidget {
  const BusinesListItem({
    super.key,
    required this.businessItem,
    required this.onSelect,
  });

  final Business businessItem;
  final void Function() onSelect;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      child: Builder(
        builder: (BuildContext context) {
          try {
            return Image.memory(base64.decode(businessItem.imageUrl!));
          } catch (e) {
            return Image.asset(
              'assests/home.png',
              height: MediaQuery.of(context).size.height * 0.122,
            );
          }
        },
      ),
    );
  }
}
