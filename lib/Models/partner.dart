class Partner {
  final int id;
  final String name;
  final String description;
  final String email;
  final int phone;
  final String image;
  final String category;
  final String openingtime;
  final String closingtime;
  double? lat;
  double? long;
  String? adress;
  bool? likes;

  Partner({
    required this.id,
    required this.name,
    required this.description,
    required this.email,
    required this.phone,
    required this.image,
    required this.category,
    required this.openingtime,
    required this.closingtime,
    required this.lat,
    required this.long,
    this.adress,
    this.likes,
  });

  factory Partner.fromJson(Map<String, dynamic> json) {
    return Partner(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      email: json['email'],
      phone: json['phone'],
      image: json['image'],
      category: json['category'],
      openingtime: json['openingtime'],
      closingtime: json['closingtime'],
      long: json['long'],
      lat: json['lat'],
      adress: json['adress'],
      likes: json["is_liked"] == 1 ? true : false,
    );
  }
}
