class Partner {
  final String name;
  final String description;
  final String email;
  final int phone;
  final String image;
  final String category;
  final String openingtime;
  final String closingtime;

  Partner({
    required this.name,
    required this.description,
    required this.email,
    required this.phone,
    required this.image,
    required this.category,
    required this.openingtime,
    required this.closingtime,
  });
  factory Partner.fromJson(Map<String, dynamic> json) {
    return Partner(
      name: json['name'],
      description: json['description'],
      email: json['email'],
      phone: json['phone'],
      image: json['image'],
      category: json['category'],
      openingtime: json['openingtime'],
      closingtime: json['closingtime'],
    );
  }
}
