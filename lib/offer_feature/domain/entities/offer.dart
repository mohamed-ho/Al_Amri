import 'dart:io';

import 'package:equatable/equatable.dart';

class Offer extends Equatable {
  final int id;
  final String title;
  final String description;
  final List<int> typesId;
  final int price;
  final int discount;
  final List<int> quantity;
  final String image;
  final File? imageFile;

  const Offer(
      {required this.id,
      required this.title,
      required this.description,
      required this.typesId,
      required this.price,
      required this.discount,
      required this.quantity,
      required this.image,
      required this.imageFile});

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        typesId,
        price,
        discount,
        quantity,
        image,
        imageFile
      ];
}
