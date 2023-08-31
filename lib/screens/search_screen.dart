import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iBar/models/business_model.dart';
import 'package:iBar/widgets/search_bar.dart';
import 'package:iBar/widgets/search_res.dart';
import 'package:iBar/data/data.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.passStr});
  final String passStr;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNodeOfSearchBar = FocusNode();
  final FocusNode _focusNodeOfSilverAppBar = FocusNode();
  List<Business> searchResults = [];

  void searchRes(String string) {
    setState(() {
      searchResults = businessList.where((business) {
        return business.name.contains(string);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return RawKeyboardListener(
      focusNode: _focusNodeOfSilverAppBar,
      onKey: (RawKeyEvent event) {
        if (event is RawKeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.enter) {
          String keywords = _searchController.text;
          searchRes(keywords);
        }
      },
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: MySearchBar(
              focusNode: _focusNodeOfSearchBar,
              onSearch: searchRes,
              searchController: _searchController,
            ),
            expandedHeight: deviceHeight * 0.2,
          ),
          SliverAnimatedList(
            initialItemCount: 2,
            itemBuilder: (context, index, animation) {
              return SearchResults(businessList: searchResults);
            },
          )
        ],
      ),
    );
  }
}
