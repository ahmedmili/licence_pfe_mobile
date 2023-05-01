import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class PartnerCategory extends Equatable {
  final String name;
  final int index;
  late bool isSelected;

  PartnerCategory({
    required this.name,
    required this.index,
    this.isSelected = false,
  });

  @override
  List<Object?> get props => [name, index, isSelected];

  factory PartnerCategory.fromSnapshot(Map<String, dynamic> snap) {
    return PartnerCategory(
      name: snap['name'],
      index: snap['index'],
    );
  }

  static List<PartnerCategory> partnercategories = [
    PartnerCategory(
      name: 'SUPERMARKET',
      index: 0,
    ),
    PartnerCategory(
      name: 'BAKERY',
      index: 1,
    ),
    PartnerCategory(
      name: 'PASTRIES',
      index: 2,
    ),
    PartnerCategory(
      name: 'RESTAURANT',
      index: 3,
    ),
    PartnerCategory(
      name: 'COFFEE SHOP',
      index: 4,
    ),
    PartnerCategory(
      name: 'HOTEL',
      index: 5,
    ),
    PartnerCategory(
      name: 'CATERER',
      index: 6,
    ),
    PartnerCategory(
      name: 'LOCAL PRODUCERS',
      index: 7,
    ),
  ];
}
