import 'package:flutter/material.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar(
      {super.key,
      required this.focusNode,
      required this.onSearch,
      required this.searchController});
  final FocusNode focusNode;
  final Function(String, bool, bool) onSearch;
  final TextEditingController searchController;

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  @override
  void initState() {
    super.initState();
    widget.focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      height: deviceHeight * 0.05,
      padding: EdgeInsets.all(deviceWidth * 0.001),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.grey[300],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: TextFormField(
              controller: widget.searchController,
              keyboardType: TextInputType.text,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
              focusNode: widget.focusNode,
              onTap: () {
                widget.focusNode.requestFocus();
              },
              onFieldSubmitted: (value) {
                var keywords = widget.searchController.text;
                widget.onSearch(keywords, true, false);
              },
              onTapOutside: (event) => widget.focusNode.unfocus(),
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
                contentPadding: EdgeInsets.only(
                    left: deviceWidth * 0.001, bottom: deviceHeight * 0.01),
                border: InputBorder.none,
                icon: Image.asset(
                  'assests/beer.png',
                  width: deviceWidth * 0.09,
                  height: deviceHeight * 0.09,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              var keywords = widget.searchController.text;
              widget.onSearch(keywords, true, false);
            },
            icon: const Icon(Icons.search, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
