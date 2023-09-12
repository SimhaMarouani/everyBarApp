import 'package:flutter/material.dart';
import 'package:iBar/models/business_model.dart';
import 'package:iBar/screens/business_home_page.dart';
import 'package:iBar/widgets/business_item_w_img.dart';
import 'package:iBar/widgets/business_item_w_logo.dart';

class BusinessListV extends StatefulWidget {
  const BusinessListV({
    super.key,
    required this.bList,
  });
  final List<Business> bList;

  @override
  State<BusinessListV> createState() => _BusinessVListState();
}

class _BusinessVListState extends State<BusinessListV> {
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

    return ListView.builder(
      itemCount: widget.bList.length,
      itemBuilder: (ctx, index) {
        final business = widget.bList[index];
        return GestureDetector(
          onTap: () => _selectBusiness(context, business),
          child: Padding(
            padding: EdgeInsets.all(deviceHeight * 0.02),
            child: Row(
              children: [
                Container(
                  height: deviceHeight * 0.2,
                  width: deviceWidth * 0.35,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
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
                        padding:
                            EdgeInsets.only(right: deviceWidth * 0.35 * 0.1),
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
                SizedBox(
                  width: deviceWidth * 0.5,
                  height: deviceHeight * 0.2,
                  child: BusinesListItemLogo(
                    businessItem: widget.bList[index],
                    onSelect: () {
                      _selectBusiness(context, widget.bList[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
