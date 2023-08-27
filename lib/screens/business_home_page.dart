import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iBar/models/business_model.dart';

class BusinessHomePage extends ConsumerWidget {
  const BusinessHomePage({
    super.key,
    required this.businessModel,
  });
  final Business businessModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      drawer: null,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
                  child: child,
                );
              },
              child: const Icon(
                Icons.star,
              ),
            ),
          ),
        ],
        title: Text(businessModel.name),
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [],
      ),
    );
  }
}
