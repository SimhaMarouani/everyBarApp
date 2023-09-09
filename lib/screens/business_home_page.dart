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
  const BusinessHomePage({
    super.key,
    required this.businessModel,
  });
  final Business businessModel;

  final String defaultImageUrl = 'assests/home.png';

  void _handleRatingChanged(int rating) {}

  Future<Uint8List> _fetchImage() async {
    try {
      final response = await http.get(Uri.parse(businessModel.imageUrl!));
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
              height: deviceHeight * 0.4,
              child: Stack(
                children: [
                  Center(
                    child: FutureBuilder<Uint8List>(
                      future: _fetchImage(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.data != null &&
                            snapshot.data!.isNotEmpty) {
                          return Image.memory(
                            width: double.infinity,
                            snapshot.data!,
                            height: deviceHeight,
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
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: BusinessPageButtons(business: businessModel),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: deviceWidth * 0.05, top: deviceHeight * 0.05),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.0),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: deviceWidth * 0.85, top: deviceHeight * 0.05),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.0),
                      ),
                      child: IconButton(
                        onPressed: () {
                          final wasAdded = ref
                              .read(favoriteBusinessProvider.notifier)
                              .toggleMealFavoriteStatus(businessModel);
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(wasAdded
                                  ? 'Marked As Favorites'
                                  : 'Removed')));
                        },
                        icon: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder: (child, animation) {
                            return RotationTransition(
                              turns: Tween<double>(begin: 0.5, end: 1.0)
                                  .animate(animation),
                              child: child,
                            );
                          },
                          child: Icon(
                            isFav ? Icons.star : Icons.star_border,
                            key: ValueKey(isFav),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
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
              initialRating: businessModel.ratingAvg,
              onRatingChanged: _handleRatingChanged,
            ),
          ],
        ),
      ),
    );
  }
}
