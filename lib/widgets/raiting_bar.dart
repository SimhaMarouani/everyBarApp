import 'package:flutter/material.dart';

class StarRating extends StatefulWidget {
  final Function(int) onRatingChanged;
  final int initialRating;
  final int maxRating;

  StarRating({
    required this.onRatingChanged,
    this.initialRating = 0,
    this.maxRating = 5,
  }) : assert(initialRating >= 0 && initialRating <= maxRating);

  @override
  _StarRatingState createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  int _rating = 0;

  @override
  void initState() {
    super.initState();
    _rating = widget.initialRating;
  }

  Widget _buildStar(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _rating = index + 1;
          widget.onRatingChanged(_rating);
        });
      },
      child: Icon(
        index < _rating ? Icons.star : Icons.star_border,
        color: Theme.of(context).hintColor,
        size: 30,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.maxRating, (index) {
        return _buildStar(index);
      }),
    );
  }
}
