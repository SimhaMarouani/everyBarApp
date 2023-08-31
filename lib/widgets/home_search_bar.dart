import 'package:flutter/material.dart';

class FakeSearchBar extends StatelessWidget {
  const FakeSearchBar({super.key, required this.onPress});
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    // var deviceHeight = MediaQuery.of(context).size.height;
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
              const Text("Search"),
            ],
          ),
        ),
        Positioned(
          right: 100, // Adjust the right position of the microphone button
          child: IconButton(
            onPressed: () {
              // Handle microphone button press
            },
            icon: const Icon(Icons.mic),
          ),
        ),
      ],
    );
  }
}
