import 'package:flutter/material.dart';
import 'package:iBar/models/business_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AddBusinessScreen extends StatefulWidget {
  const AddBusinessScreen({super.key});

  @override
  State<AddBusinessScreen> createState() => _AddBusinessScreenState();
}

class _AddBusinessScreenState extends State<AddBusinessScreen> {
  PageController pageController = PageController();
  FocusNode focusNode = FocusNode();
  int _currentPage = 0;
  List<TextEditingController> textInputs = List.generate(
      3, // Number of text inputs you want to create
      (index) => TextEditingController());

  List<GlobalKey<FormState>> formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];
  Row buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(formKeys.length, (index) {
        return Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
          child: Container(
            width: 8.0,
            height: 8.0,
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentPage == index
                  ? Colors.white // Color for current page dot
                  : Colors.white
                      .withOpacity(0.3), // Color for inactive page dots
            ),
          ),
        );
      }),
    );
  }

  List<String> inputs = ['Name', 'Where is it located?', 'Pick Image'];
  String? imagePath; // Added to store the image path

  List<String> formData = List.filled(3, '');

  Future<void> addBusiness(Business business) async {
    const serverUrl =
        'http://127.0.0.1:5000'; // Replace with your server's IP address
    final response = await http.post(
      Uri.parse('$serverUrl/add_business'),
      body: json.encode({'business': business.toJson()}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print('business added successfully');
    } else {
      print('Failed to business user. Status code: ${response.statusCode}');
    }
  }

  void _goToNextPage() {
    if (formKeys[_currentPage].currentState!.validate()) {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.bounceInOut,
      );
    }
  }

  Future<void> _getImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          imagePath = pickedFile.path;
        });
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  void _submitForm() {
    if (formKeys[_currentPage].currentState!.validate()) {
      Business newBuisness = Business(name: formData[0], location: formData[1]);
      addBusiness(newBuisness);
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.velocity.pixelsPerSecond.dx > 0) {
          if (_currentPage > 0) {
            pageController.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Cubic(0.32, 0.92, 0.12, 1.0),
            );
          }
        } else {
          if (_currentPage != formKeys.length - 1) {
            _goToNextPage();
          } else {
            _submitForm();
          }
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).hintColor,
        appBar: AppBar(
          title: Text(
            'Add New Business',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
        body: PageView.builder(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          itemCount: formKeys.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKeys[index],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: deviceHeight * 0.4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            inputs[index],
                            style: const TextStyle(
                                fontSize: 40, fontFamily: 'Tangerine'),
                          ),
                          index != 2
                              ? TextFormField(
                                  controller: textInputs[index],
                                  autocorrect: false,
                                  focusNode: focusNode,
                                  onTapOutside: (event) => focusNode.unfocus(),
                                  onTap: () => focusNode.requestFocus(),
                                  onChanged: (value) {
                                    setState(() {
                                      formData[index] = value;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    labelText: "Enter Here",
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter the field';
                                    }
                                    return null;
                                  },
                                )
                              : imagePath != null
                                  ? SizedBox(
                                      width: 100.0,
                                      height: 100.0,
                                      child: Image.file(
                                        File(imagePath!), // Import 'dart:io'
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : ElevatedButton(
                                      onPressed: _getImage,
                                      child: Text('Select Image'),
                                    ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Swipe Left To Continue",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    buildPageIndicator(),
                  ],
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: BottomAppBar(
          color: Theme.of(context).hintColor.withAlpha(120),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            height: 70.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_currentPage > 0) {
                      pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Cubic(0.32, 0.92, 0.12, 1.0),
                      );
                    }
                  },
                  child: const Text('Previous'),
                ),
                ElevatedButton(
                  onPressed: _currentPage == formKeys.length - 1
                      ? _submitForm
                      : _goToNextPage,
                  child: Text(
                    _currentPage == formKeys.length - 1 ? 'Submit' : 'Next',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
