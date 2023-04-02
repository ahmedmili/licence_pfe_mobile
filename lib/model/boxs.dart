class Box {
  final int id;
  final String title;
  final String description;
  final String oldprice;
  final String newprice;
  final String startdate;

  final String enddate;
  final int quantity;
  final int remainingQuantity;

  final String image;
  final String category;
  final int partnerId;

  Box({
    required this.newprice,
    required this.startdate,
    required this.enddate,
    required this.quantity,
    required this.remainingQuantity,
    required this.image,
    required this.category,
    required this.partnerId,
    required this.id,
    required this.title,
    required this.description,
    required this.oldprice,
  });

  factory Box.fromJson(Map<String, dynamic> json) {
    return Box(
      id: json['id'],
      description: json['description'],
      category: json['category'],
      newprice: json['newprice'],
      startdate: json['startdate'],
      enddate: json['enddate'],
      quantity: json['quantity'],
      remainingQuantity: json['remaining_quantity'],
      image: json['image'],
      partnerId: json['partner_id'],
      title: json['title'],
      oldprice: json['oldprice'],
    );
  }
}
