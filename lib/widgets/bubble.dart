import 'package:flutter/material.dart';

class Bubble extends StatefulWidget {
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
  State<Bubble> createState() => _BubbleState();
}

class _BubbleState extends State<Bubble> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.left,
      top: widget.top,
      child: GestureDetector(
        onTap: widget.onSelect,
        child: Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Theme.of(context).primaryColor.withOpacity(0.01),
                Theme.of(context).secondaryHeaderColor,
              ],
            ),
            boxShadow: [
              BoxShadow(
                blurStyle: BlurStyle.inner,
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Text(
              widget.name,
              style: TextStyle(
                fontSize: widget.size * 0.2,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
