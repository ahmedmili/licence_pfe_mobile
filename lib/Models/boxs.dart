class Box {
  final int id;
  final String title;
  final String description;
  final String oldprice;
  final String newprice;
  final String startdate;

  final String enddate;
  final int quantity;
  final int remaining_quantity;

  final String image;
  final String category;
  final int partnerId;

  String? status;
  int? likes;

  Box(
      {required this.newprice,
      required this.startdate,
      required this.enddate,
      required this.quantity,
      required this.remaining_quantity,
      required this.image,
      required this.category,
      required this.partnerId,
      required this.id,
      required this.title,
      required this.description,
      required this.oldprice,
      this.status,
      this.likes});

  factory Box.fromJson(Map<String, dynamic> json) {
    return Box(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      oldprice: json['oldprice'],
      newprice: json['newprice'],
      startdate: json['startdate'],
      enddate: json['enddate'],
      quantity: json['quantity'],
      remaining_quantity: json['remaining_quantity'],
      image: json['image'],
      category: json['category'],
      status: json['status'],
      partnerId: json['partner_id'],
      likes: json["likes"].length,
    );
  }
}
