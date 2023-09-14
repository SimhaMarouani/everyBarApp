import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iBar/models/business_model.dart';
import 'package:iBar/widgets/business_list_vertical.dart';
import 'package:iBar/widgets/search_bar.dart';
import 'package:iBar/data/data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  Future<void> addWord(String word) async {
    const serverUrl =
        'http://127.0.0.1:5000'; // Replace with your server's IP address
    final response = await http.put(
      Uri.parse('$serverUrl/add_word'),
      body: json.encode({'word': word}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print('Word added successfully');
    } else {
      print('Failed to add word. Status code: ${response.statusCode}');
    }
  }

  Future<void> getSuggestions(String word) async {
    const serverUrl =
        'http://127.0.0.1:5000'; // Replace with your server's IP address
    final response =
        await http.get(Uri.parse('$serverUrl/suggest_word?word=$word'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final suggestions = data['suggestions'];
      print('Suggestions: $suggestions');
    } else {
      print('Failed to fetch suggestions. Status code: ${response.statusCode}');
    }
  }

  List<Business> searchByKeywords(String lowercaseSearchQuery) {
    List<Business> newList = [];

    // Split the search query into individual keywords
    List<String> keywords = lowercaseSearchQuery.split(' ');

    for (var business in businessList) {
      bool matchFound = false;

      // Check if the business name contains any of the keywords
      final String lowercaseBusinessName = business.name.toLowerCase();
      if (keywords
          .every((keyword) => lowercaseBusinessName.contains(keyword))) {
        newList.add(business);
        matchFound = true;
      }

      // Check if the location contains any of the keywords
      final String lowercaseLocation = business.location.toLowerCase();
      if (keywords.every((keyword) => lowercaseLocation.contains(keyword))) {
        newList.add(business);
        matchFound = true;
      }

      // If no direct matches are found, try to predict based on the first keyword
      if (!matchFound && keywords.isNotEmpty) {
        final String firstKeyword = keywords[0];
        if (lowercaseBusinessName.startsWith(firstKeyword) ||
            lowercaseLocation.startsWith(firstKeyword)) {
          newList.add(business);
        }
      }
    }

    return newList;
  }

  List<String> businessToStringList(List<Business> businesses) {
    List<String> resultList = [];
    for (var business in businesses) {
      // Concatenate all properties of the Business object to create a string
      String businessString = "${business.name}, ${business.location}";
      resultList.add(businessString);
    }
    return resultList;
  }

  void searchRes(String string, bool isSearching, bool isEmpty) {
    final String lowercaseSearchQuery = string.toLowerCase();

    setState(() {});
  }

  void handleKeyEvent(RawKeyEvent event) {
    String keywords = _searchController.text;

    if (event is RawKeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace) {
      if (keywords.length == 1) {
        searchRes(keywords, false, true);
      } else {
        searchRes(keywords, false, false);
      }
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
    final deviceWidth = MediaQuery.of(context).size.width;
    return RawKeyboardListener(
      focusNode: _focusNodeOfSilverAppBar,
      onKey: handleKeyEvent,
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
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return SizedBox(
                    height: deviceHeight * 0.63,
                    child: const BusinessListV(bList: businessList));
              },
            ),
          ),
        ],
      ),
    );
  }
}
