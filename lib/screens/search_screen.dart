import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iBar/models/business_model.dart';
import 'package:iBar/widgets/business_list_generator.dart';
import 'package:iBar/widgets/search_bar.dart';
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
  BusinessList searchResult = const BusinessList(isList: true, bList: []);

  BusinessList searchByKeywords(String lowercaseSearchQuery) {
    List<Business> newList = [];
    for (var i in businessList) {
      final String lowercaseText = i.name.toLowerCase();
      if (lowercaseText.contains(lowercaseSearchQuery) ||
          lowercaseSearchQuery.startsWith(lowercaseText)) {
        newList.add(i);
      }
      for (var key in i.menu.keys) {
        String newKey = key.toLowerCase();
        if (newKey.contains(lowercaseSearchQuery)) newList.add(i);
      }
    }
    return BusinessList(
      bList: newList,
      isList: false,
    );
  }

  void searchRes(String string) {
    final String lowercaseSearchQuery = string.toLowerCase();

    setState(() {
      searchResult = searchByKeywords(lowercaseSearchQuery);
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
          if (keywords.isNotEmpty) searchRes(keywords);
        }
      },
      child: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                "assests/background.jpg",
                fit: BoxFit.fill,
              ),
            ),
          ),
          CustomScrollView(
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
                initialItemCount: 1,
                itemBuilder: (context, index, animation) {
                  return Column(
                    children: [
                      if (searchResult.bList.isNotEmpty)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [searchResult],
                        )
                    ],
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
