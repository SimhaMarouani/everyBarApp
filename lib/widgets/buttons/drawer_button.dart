import 'package:flutter/material.dart';

class MyDrawerButton extends StatelessWidget {
  const MyDrawerButton(
      {super.key,
      required this.TextToShow,
      required this.icon,
      required this.onTap});
  final Icon icon;
  final String TextToShow;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Theme.of(context)
                  .secondaryHeaderColor
                  .withAlpha(200); // Change to grey when pressed
            }
            return Colors.grey[300]; // Default color
          },
        ),
      ),
      onPressed: onTap,
      child: Text(
        TextToShow,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 24,
            ),
      ),
    );
  }
}
