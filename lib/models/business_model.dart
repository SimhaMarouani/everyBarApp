import 'dart:convert';

class Business {
  const Business({
    required this.name,
    this.imageUrl,
    this.logoUrl,
    required this.openTime,
    required this.closedTime,
    required this.location,
    required this.hasHappyHour,
    this.menu,
    required this.age,
    required this.hasFood,
    required this.isKosher,
    required this.loud,
    required this.smoke,
    this.phone,
    required this.ratingAvg,
  });
  final String name;
  final String? imageUrl;
  final String? logoUrl;

  final String openTime;
  final String closedTime;
  final String location;
  final int age;
  final bool smoke;
  final bool loud;
  final bool hasFood;
  final bool isKosher;
  final bool hasHappyHour;
  final Map? menu;
  final String? phone;
  final int ratingAvg;

  Map<String, dynamic> toJson() {
    return {
      'age': age,
      'hasFood': hasFood,
      'isKosher': isKosher,
      'loud': loud,
      'smoke': smoke,
      'name': name,
      'menu': menu,
      'imageUrl': imageUrl,
      'logoUrl': logoUrl,
      'openTime': openTime,
      'closedTime': closedTime,
      'location': location,
      'hasHappyHour': hasHappyHour,
      'phone': phone,
      'ratingAvg': ratingAvg,
    };
  }

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      name: json['name'],
      phone: json['phone'],
      ratingAvg: json['ratingAvg'],
      smoke: json['smoke'],
      age: json['age'],
      menu: json['menu'],
      imageUrl: json['imageUrl'],
      logoUrl: json['logoUrl'],
      location: json['location'],
      loud: json['loud'],
      openTime: json['openTime'],
      closedTime: json['closedTime'],
      hasFood: json['hasFood'],
      hasHappyHour: json['hasHappyHour'],
      isKosher: json['isKosher'],
    );
  }
}

List<Business> businessesFromJson(String json) {
  final List<dynamic> parsed = jsonDecode(json);
  return parsed.map((e) => Business.fromJson(e)).toList();
}
