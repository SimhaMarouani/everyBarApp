import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iBar/data/Headlines.dart';
import 'package:iBar/providers/language_provider.dart';

class FakeSearchBar extends ConsumerWidget {
  const FakeSearchBar({super.key, required this.onPress});
  final Function onPress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLanguage = ref.watch(currentLanguageProvider);
    final selectedMap = selectedLanguageMap[selectedLanguage];
    var deviceWidth = MediaQuery.of(context).size.width;

    return Stack(
      alignment: Alignment.centerRight, // Align the mic button to the right
      children: [
        ElevatedButton(
          onPressed: () {
            onPress("");
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(deviceWidth * 0.02),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            backgroundColor: Colors.grey[300],
          ),
          child: Row(
            children: [
              const Icon(Icons.search),
              SizedBox(width: deviceWidth * 0.01),
              Text(selectedMap?["search"] ?? "Search"),
            ],
          ),
        ),
        Positioned(
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.mic, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
