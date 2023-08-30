import 'package:flutter/material.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar({
    super.key,
    required this.focusNode,
    required this.onSearch,
  });
  final FocusNode focusNode;
  final Function(String, MySearchBar, BuildContext) onSearch;

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(20),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.secondary,
            Theme.of(context).colorScheme.primaryContainer.withOpacity(0.8)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: TextFormField(
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
              focusNode: widget.focusNode,
              onTap: () {
                widget.focusNode.requestFocus();
              },
              onTapOutside: (event) => widget.focusNode.unfocus(),
              decoration: InputDecoration(
                labelText: 'Tap to search..',
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                labelStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
                border: InputBorder.none,
                alignLabelWithHint: true,
                icon: Image.asset(
                  'assests/beer.png',
                  width: deviceWidth * 0.1,
                  height: deviceHeight * 0.1,
                ),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(10),
              backgroundColor: Theme.of(context).colorScheme.secondary,
            ),
            onPressed: () {
              String keywords = _searchController.text;
              widget.onSearch(keywords, widget, context);
            },
            child: const Icon(Icons.search),
          ),
        ],
      ),
    );
  }
}
