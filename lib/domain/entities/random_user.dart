class RandomUser {
  RandomUser({
    this.id,
    required this.gender,
    required this.name,
    required this.email,
    required this.picture,
    required this.city,
  });

  int? id;
  String name;
  final String gender;
  final String email;
  final String picture;
  String city;
}
