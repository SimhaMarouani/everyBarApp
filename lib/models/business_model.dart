import 'dart:convert';

class Business {
  const Business({
    required this.name,
    this.imageUrl,
    this.logoUrl,
    this.openTime,
    this.closedTime,
    this.location,
    this.hasHappyHour,
    this.menu,
    this.age,
    this.hasFood,
    this.isKosher,
    this.loud,
    this.smoke,
    this.phone,
    this.ratingAvg,
  });
  final String name;
  final String? imageUrl;
  final String? logoUrl;
  final String? openTime;
  final String? closedTime;
  final String? location;
  final int? age;
  final bool? smoke;
  final bool? loud;
  final bool? hasFood;
  final bool? isKosher;
  final bool? hasHappyHour;
  final Map? menu;
  final String? phone;
  final int? ratingAvg;

  Map<String, dynamic> toJson() {
    return {
      'age': age ?? 1,
      'hasFood': hasFood ?? false,
      'isKosher': isKosher ?? false,
      'loud': loud ?? false,
      'smoke': smoke ?? false,
      'name': name,
      'menu': menu ?? {},
      'imageUrl': imageUrl ?? "null",
      'logoUrl': logoUrl ?? "null",
      'openTime': openTime ?? "null",
      'closedTime': closedTime ?? "null",
      'location': location ?? "null",
      'hasHappyHour': hasHappyHour ?? "null",
      'phone': phone ?? "null",
      'ratingAvg': ratingAvg ?? 1,
    };
  }

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      name: json['name'],
      phone: json['phone'] ?? "null",
      ratingAvg: json['ratingAvg'] ?? 1,
      smoke: json['smoke'] ?? false,
      age: json['age'] ?? 0,
      imageUrl: json['imageUrl'] == "" ? "" : json['imageUrl'],
      logoUrl: json['logoUrl'] == "" ? "" : json['logoUrl'],
      location: json['location'] ?? "null",
      loud: json['loud'] ?? false,
      openTime: json['openTime'] ?? "null",
      closedTime: json['closedTime'] ?? "null",
      hasFood: json['hasFood'] ?? false,
      hasHappyHour: json['hasHappyHour'] ?? false,
      isKosher: json['isKosher'] ?? false,
      menu: json['menu'] ?? {},
    );
  }
}

List<Business> businessesFromJson(String json) {
  final List<dynamic> parsed = jsonDecode(json);
  List<Business> businessList = [];

  for (var item in parsed) {
    businessList.add(Business.fromJson(item));
  }

  return businessList.toList();
}
