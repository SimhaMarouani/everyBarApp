import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:iBar/models/business_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

Future<void> addBusiness() async {
  const business = Business(
    age: 18,
    hasFood: false,
    isKosher: false,
    loud: false,
    smoke: true,
    name: "ברוך",
    menu: {"Cocktail": 41.50, "Cola": 13},
    imageUrl:
        "/Users/barkobi/developments/flutter_projects/ibar_app/assests/baruh.png",
    logoUrl:
        "/Users/barkobi/developments/flutter_projects/ibar_app/assests/home.png",
    openTime: "20:00",
    closedTime: "2:00",
    location: "נחלת שבעה 11",
    hasHappyHour: false,
    phone: "0544544163",
    ratingAvg: 3,
  );
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

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
          icon: Icon(Icons.add),
          onPressed: () => addBusiness(),
        ),
      ),
    );
  }
}
