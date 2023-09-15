import 'package:flutter/material.dart';
import 'package:iBar/models/business_model.dart';
import 'package:iBar/screens/business_home_page.dart';
import 'package:iBar/widgets/business_item_w_logo.dart';
import 'package:iBar/widgets/vertical_list_text.dart';

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
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: deviceHeight * 0.17,
                  width: deviceWidth * 0.45,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                  ),
                  child: VerticalListTexts(business: widget.bList[index]),
                ),
                SizedBox(
                  width: deviceHeight * 0.17,
                  height: deviceHeight * 0.17,
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
