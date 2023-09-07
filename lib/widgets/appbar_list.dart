import 'dart:math';

import 'package:flutter/material.dart';
import 'package:iBar/models/business_model.dart';

class ListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: deviceHeight * 0.065,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Wrap(
            spacing: 8.0,
            children: List.generate(
              10,
              (index) {
                Random random = Random();
                int randomNumber = random.nextInt(3);
                return InkWell(
                  onTap: () {},
                  child: Container(
                    width: randomNumber == 0
                        ? deviceWidth * 0.2
                        : (randomNumber == 1
                            ? deviceWidth * 0.25
                            : deviceWidth * 0.3),
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(25.0),
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                    child: Center(
                      child: Text(
                        'Business $index',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
