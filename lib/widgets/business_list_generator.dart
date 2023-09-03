import 'package:flutter/material.dart';
import 'package:iBar/models/business_model.dart';
import 'package:iBar/screens/business_home_page.dart';
import 'package:iBar/widgets/business_item.dart';

class BusinessList extends StatefulWidget {
  const BusinessList({
    super.key,
    this.animationController,
    required this.isList,
    required this.bList,
    required this.isSearching,
  });
  final AnimationController? animationController;
  final bool isList;
  final bool isSearching;
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
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final animationController = widget.animationController;
    final offset =
        animationController != null ? const Offset(0.7, 0) : const Offset(0, 0);
    final height =
        animationController == null ? deviceHeight : deviceHeight * 0.3;
    final widgetToDisplay = widget.isList
        ? ListView.builder(
            padding: const EdgeInsets.only(top: 10),
            itemCount: widget.bList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(
                  top: 8.0, left: deviceWidth * 0.05, right: 8.0, bottom: 8),
              child: BusinesListItem(
                isSearching: widget.isSearching,
                businessItem: widget.bList[index],
                onSelect: () {
                  _selectBusiness(context, widget.bList[index]);
                },
              ),
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.only(top: 10),
            itemCount: widget.bList.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    EdgeInsets.only(top: index != 0 ? deviceHeight * 0.15 : 0),
                child: BusinesListItem(
                  businessItem: widget.bList[index],
                  isSearching: widget.isSearching,
                  onSelect: () {
                    _selectBusiness(context, widget.bList[index]);
                  },
                ),
              );
            },
          );

    return AnimatedBuilder(
        animation:
            widget.animationController ?? const AlwaysStoppedAnimation(0.0),
        child: SizedBox(
            width: deviceWidth, height: height, child: widgetToDisplay),
        builder: (ctx, child) {
          return SlideTransition(
            position: Tween(
              begin: offset,
              end: const Offset(0, 0),
            ).animate(
              CurvedAnimation(
                  parent: widget.animationController ??
                      const AlwaysStoppedAnimation(0.0),
                  curve: Curves.easeInOut),
            ),
            child: child,
          );
        });
  }
}
