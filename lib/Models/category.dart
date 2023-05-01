import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Category extends Equatable {
  final String name;
  final int index;
  late bool isSelected;

  Category({
    required this.name,
    required this.index,
    this.isSelected = false,
  });

  @override
  List<Object?> get props => [name, index, isSelected];

  factory Category.fromSnapshot(Map<String, dynamic> snap) {
    return Category(
      name: snap['name'],
      index: snap['index'],
    );
  }

  static List<Category> categories = [
    Category(
      name: 'FRUITS AND VEGETABLES',
      index: 0,
    ),
    Category(
      name: 'MEAT',
      index: 1,
    ),
    Category(
      name: 'PASTRY',
      index: 2,
    ),
    Category(
      name: 'FISH',
      index: 3,
    ),
    Category(
      name: 'DAIRY PRODUCTS',
      index: 4,
    ),
    Category(
      name: 'PREPARED DISHES',
      index: 5,
    ),
    Category(
      name: 'SWEETS',
      index: 6,
    ),
    Category(
      name: 'DRINKS',
      index: 7,
    ),
    Category(
      name: 'VEGETARIAN',
      index: 8,
    ),
  ];
}
