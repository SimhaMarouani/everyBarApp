class Business {
  const Business({
    required this.name,
    required this.imageUrl,
    required this.openTime,
    required this.closedTime,
    required this.location,
    required this.hasHappyHour,
    required this.menu,
    required this.age,
    required this.hasFood,
    required this.isKosher,
    required this.loud,
    required this.smoke,
  });
  final String name;
  final String imageUrl;
  final String openTime;
  final String closedTime;
  final String location;
  final int age;
  final bool smoke;
  final bool loud;
  final bool hasFood;
  final bool isKosher;
  final bool hasHappyHour;
  final Map menu;
}
