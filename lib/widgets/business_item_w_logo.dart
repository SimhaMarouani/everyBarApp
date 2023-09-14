import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:iBar/models/business_model.dart';
import 'package:http/http.dart' as http;

class BusinesListItemLogo extends StatelessWidget {
  const BusinesListItemLogo({
    super.key,
    required this.businessItem,
    required this.onSelect,
  });

  final Business businessItem;
  final void Function() onSelect;

  @override
  Widget build(BuildContext context) {
    const String defaultImageUrl = 'assests/home.png';

    Future<Uint8List> _fetchImage() async {
      try {
        final response = await http.get(Uri.parse(businessItem.logoUrl!));
        if (response.statusCode == 200) {
          return response.bodyBytes;
        }
      } catch (e) {}
      return Uint8List(0);
    }

    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topRight: Radius.circular(16), bottomRight: Radius.circular(16)),
      child: FutureBuilder<Uint8List>(
        future: _fetchImage(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.data != null && snapshot.data!.isNotEmpty) {
            return Image.memory(snapshot.data!, fit: BoxFit.cover);
          } else {
            return Image.asset(
              defaultImageUrl,
            );
          }
        },
      ),
    );
  }
}
