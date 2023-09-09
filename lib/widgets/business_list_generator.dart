import 'package:flutter/material.dart';
import 'package:iBar/models/business_model.dart';
import 'package:iBar/screens/business_home_page.dart';
import 'package:iBar/widgets/business_item.dart';

class BusinessList extends StatefulWidget {
  const BusinessList({
    super.key,
    required this.animationController,
    required this.isList,
    required this.bList,
  });
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
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    const offset = Offset(0.7, 0);

    return AnimatedBuilder(
        animation:
            widget.animationController ?? const AlwaysStoppedAnimation(0.0),
        child: SizedBox(
          height: deviceHeight * 0.25,
          width: deviceWidth,
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 10),
            itemCount: widget.bList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(
                  top: 8.0, left: deviceWidth * 0.05, right: 8.0, bottom: 8),
              child: Column(
                children: [
                  Flexible(
                    flex: 5,
                    child: SizedBox(
                      width: deviceWidth * 0.35,
                      child: BusinesListItem(
                        businessItem: widget.bList[index],
                        onSelect: () {
                          _selectBusiness(context, widget.bList[index]);
                        },
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 4,
                    child: Container(
                      height: deviceHeight * 0.25 * 0.45,
                      width: deviceWidth * 0.35,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              right: deviceWidth * 0.35 * 0.1,
                              top: deviceHeight * 0.25 * 0.4 * 0.1,
                            ),
                            child: Text(
                              widget.bList[index].name,
                              style: TextStyle(
                                  fontSize: deviceWidth * 0.045,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: deviceWidth * 0.35 * 0.1),
                            child: Text(
                              widget.bList[index].location.toString(),
                              style: TextStyle(
                                  fontSize: deviceWidth * 0.035,
                                  fontWeight: FontWeight.w400),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        builder: (ctx, child) {
          return SlideTransition(
            position: Tween(
              begin: offset,
              end: const Offset(0, 0),
            ).animate(
              CurvedAnimation(
                  parent: widget.animationController, curve: Curves.easeInOut),
            ),
            child: child,
          );
        });
  }
}
