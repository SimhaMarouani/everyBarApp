import 'package:flutter/material.dart';

class SearchPads extends StatelessWidget {
  const SearchPads({
    super.key,
    required this.animationController,
  });
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      child: Row(
          children: List.generate(
              4,
              (index) => Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        foregroundColor:
                            Theme.of(context).colorScheme.onSecondary,
                        shape: const CircleBorder(),
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * 0.06),
                      ),
                      onPressed: () {},
                      child: const Icon(Icons.wine_bar),
                    ),
                  ))),
      builder: (ctx, child) => SlideTransition(
        position: Tween(
          begin: const Offset(0.7, 0),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
        ),
        child: child,
      ),
    );
  }
}
