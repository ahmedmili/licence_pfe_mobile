class Order {
  int? partner_id;
  final int command_id;
  final String user_name;
  final String partner_name;
  final int partner_phone;
  final String partner_email;
  final String user_email;
  final int user_phone;
  final String box_name;
  final String box_image;
  final String box_category;
  final String box_description;
  final String box_startdate;
  final String box_enddate;
  final int quantity;
  final String newprice;
  final String oldprice;
  final String created_at;
  final int price;
  final int remainingQuantity;

  Order({
    this.partner_id,
    required this.command_id,
    required this.user_name,
    required this.partner_name,
    required this.partner_email,
    required this.user_email,
    required this.user_phone,
    required this.partner_phone,
    required this.box_name,
    required this.box_category,
    required this.box_image,
    required this.box_description,
    required this.box_startdate,
    required this.box_enddate,
    required this.quantity,
    required this.oldprice,
    required this.newprice,
    required this.price,
    required this.remainingQuantity,
    required this.created_at,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      partner_id: json['command_id'],
      command_id: json['command_id'],
      user_name: json['user_name'],
      partner_name: json['partner_name'],
      partner_phone: json['partner_phone'],
      partner_email: json['partner_email'],
      user_email: json['user_email'],
      user_phone: json['user_phone'],
      box_name: json['box_name'],
      box_image: json['box_image'],
      box_startdate: json['box_startdate'],
      box_enddate: json['box_enddate'],
      box_category: json['box_category'],
      box_description: json['box_description'],
      quantity: json['quantity'],
      oldprice: json['oldprice'],
      newprice: json['newprice'],
      price: json['price'],
      remainingQuantity: json['remaining_quantity'],
      created_at: json['created_at'],
    );
  }
}
