import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iBar/data/Headlines.dart';
import 'package:iBar/models/business_model.dart';
import 'package:iBar/providers/favourite_provider.dart';
import 'package:iBar/providers/language_provider.dart';
import 'package:iBar/widgets/RaitingBar.dart';
import 'package:iBar/widgets/business_home_page_buttons.dart';
import 'package:iBar/widgets/business_page_text.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';

class BusinessHomePage extends ConsumerWidget {
  void _handleRatingChanged(int rating) {
    print('User rated the page with $rating stars.');
  }

  const BusinessHomePage({
    super.key,
    required this.businessModel,
  });
  final Business businessModel;

  final String imageUrl =
      'https://lh3.googleusercontent.com/p/AF1QipMPnQO90y2RWlbZOrAguHyD5Bz8LTnoIvMm31FV=w768-h768-n-o-k-v1';

  final String defaultImageUrl = 'assests/home.png';

  Future<Uint8List> _fetchImage() async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        return response.bodyBytes;
      }
    } catch (e) {
      print(e);
    }
    return Uint8List(0);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteBusinesses = ref.watch(favoriteBusinessProvider);
    final isFav = favoriteBusinesses.contains(businessModel);
    final selectedLanguage = ref.watch(currentLanguageProvider);
    final selectedMap = selectedLanguageMap[selectedLanguage];
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              height: deviceHeight * 0.4,
              child: Stack(
                children: [
                  Center(
                    child: FutureBuilder<Uint8List>(
                      future: _fetchImage(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.data != null &&
                            snapshot.data!.isNotEmpty) {
                          return Image.memory(
                            width: double.infinity,
                            snapshot.data!,
                            fit: BoxFit.cover,
                          );
                        } else {
                          return Image.asset(
                            defaultImageUrl,
                            fit: BoxFit.cover,
                          );
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: deviceHeight * 0.32),
                    child: BusinessPageButtons(business: businessModel),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                businessModel.name,
                style: TextStyle(
                    color: Theme.of(context).secondaryHeaderColor,
                    fontSize: deviceWidth * 0.1,
                    fontWeight: FontWeight.bold),
              ),
            ),
            BusinessPageTexts(business: businessModel),
            StarRating(
              initialRating: 0, // Set according tto the avg
              onRatingChanged: _handleRatingChanged,
            ),
          ],
        ),
      ),
    );
  }
}
