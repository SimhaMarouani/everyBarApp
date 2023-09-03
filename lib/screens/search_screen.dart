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
  var searchResult = const BusinessList(
    isList: true,
    bList: [],
    isSearching: false,
  );

  List<Business> searchByKeywords(String lowercaseSearchQuery) {
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
    return newList;
  }

  void searchRes(String string, bool isSearching, bool isEmpty) {
    final String lowercaseSearchQuery = string.toLowerCase();
    searchResult = !isEmpty
        ? BusinessList(
            bList: searchByKeywords(lowercaseSearchQuery),
            isList: false,
            isSearching: isSearching,
          )
        : const BusinessList(
            isList: true,
            bList: [],
            isSearching: false,
          );

    setState(() {});
  }

  void handleKeyEvent(RawKeyEvent event) {
    String keywords = _searchController.text;

    if (event is RawKeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace &&
        keywords.length == 1) {
      searchRes(keywords, false, true);
    } else if (event is RawKeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.enter) {
      searchRes(keywords, true, false);
    } else if (event is RawKeyDownEvent) {
      final keyLabel = event.logicalKey.keyLabel;
      if (keyLabel.isNotEmpty &&
          keyLabel.codeUnitAt(0) >= 65 &&
          keyLabel.codeUnitAt(0) <= 90) {
        searchRes(keywords, false, false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return RawKeyboardListener(
      focusNode: _focusNodeOfSilverAppBar,
      onKey: handleKeyEvent,
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
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return searchResult;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
