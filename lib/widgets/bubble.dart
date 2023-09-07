import 'package:flutter/material.dart';

class Bubble extends StatelessWidget {
  final double left;
  final double top;
  final double size;
  final void Function() onSelect;
  final String name;

  Bubble({
    required this.left,
    required this.top,
    required this.size,
    required this.onSelect,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top,
      child: GestureDetector(
        onTap: onSelect,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).highlightColor,
          ),
          child: Center(
            child: Text(
              name,
              style: TextStyle(
                fontSize: size * 0.2,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
