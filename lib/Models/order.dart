class Order {
  final int command_id;
  final String user;
  final String box_name;
  final String box_image;
  final int quantity;
  final String newprice;
  final String oldprice;
  final int remaining_quantity;

  Order({
    required this.command_id,
    required this.user,
    required this.box_name,
    required this.box_image,
    required this.quantity,
    required this.oldprice,
    required this.newprice,
    required this.remaining_quantity,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      command_id: json['command_id'],
      user: json['user'],
      box_name: json['box_name'],
      box_image: json['box_image'],
      quantity: json['quantity'],
      oldprice: json['oldprice'],
      newprice: json['newprice'],
      remaining_quantity: json['remaining_quantity'],
    );
  }
}
