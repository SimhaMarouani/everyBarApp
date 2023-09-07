import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iBar/data/Headlines.dart';
import 'package:iBar/models/business_model.dart';
import 'package:iBar/providers/favourite_provider.dart';
import 'package:iBar/providers/language_provider.dart';
import 'package:iBar/widgets/RaitingBar.dart';
import 'package:iBar/widgets/business_home_page_buttons.dart';
import 'package:iBar/widgets/business_page_text.dart';
import 'package:flutter/material.dart';

class BusinessHomePage extends ConsumerWidget {
  void _handleRatingChanged(int rating) {
    print('User rated the page with $rating stars.');
  }

  const BusinessHomePage({
    super.key,
    required this.businessModel,
  });
  final Business businessModel;

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
                  Hero(
                    tag: businessModel.name,
                    child: Image.asset(
                      "assests/baruh.png",
                      width: double.infinity,
                      height: deviceHeight * 0.3,
                      fit: BoxFit.fitWidth,
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
