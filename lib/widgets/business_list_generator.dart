import 'package:flutter/material.dart';
import 'package:iBar/data/data.dart';
import 'package:iBar/widgets/business_item.dart';

class BusinessList extends StatefulWidget {
  const BusinessList(
      {super.key, required this.animationController, required this.isList});
  final AnimationController animationController;
  final bool isList;

  @override
  State<BusinessList> createState() => _BusinessSalesListState();
}

class _BusinessSalesListState extends State<BusinessList> {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
      animation: widget.animationController,
      child: SizedBox(
        height: deviceHeight * 0.25,
        child: ListView.builder(
          padding: const EdgeInsets.only(top: 10),
          itemCount: businessList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => BusinesListItem(
            category: businessList[index],
            onSelect: () {},
          ),
        ),
      ),
      builder: (ctx, child) => SlideTransition(
        position: Tween(
          begin: const Offset(0.7, 0),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
              parent: widget.animationController, curve: Curves.easeInOut),
        ),
        child: child,
      ),
    );
  }
}
