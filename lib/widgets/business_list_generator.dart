import 'package:flutter/material.dart';
import 'package:iBar/data/data.dart';
import 'package:iBar/models/business_model.dart';
import 'package:iBar/screens/business_home_page.dart';
import 'package:iBar/widgets/business_item.dart';

class BusinessList extends StatefulWidget {
  const BusinessList(
      {super.key,
      required this.animationController,
      required this.isList,
      required this.bList});
  final AnimationController animationController;
  final bool isList;
  final List<Business> bList;

  @override
  State<BusinessList> createState() => _BusinessSalesListState();
}

class _BusinessSalesListState extends State<BusinessList> {
  void _selectBusiness(BuildContext context, Business business) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => BusinessHomePage(
          businessModel: business,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
      animation: widget.animationController,
      child: SizedBox(
        width: deviceWidth,
        height: deviceHeight * 0.22,
        child: ListView.builder(
          padding: const EdgeInsets.only(top: 10),
          itemCount: businessList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => BusinesListItem(
            businessItem: businessList[index],
            onSelect: () {
              _selectBusiness(context, businessList[index]);
            },
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
