class Business {
  const Business({
    required this.name,
    required this.imageUrl,
    required this.openTime,
    required this.closedTime,
    required this.location,
    required this.hasHappyHour,
  });
  final String name;
  final String imageUrl;
  final String openTime;
  final String closedTime;
  final String location;
  final bool hasHappyHour;
}
