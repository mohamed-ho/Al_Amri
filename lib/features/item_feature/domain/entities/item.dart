import 'dart:html' as html;
import 'package:equatable/equatable.dart';

class Item extends Equatable {
  final int id;
  final String image;
  final int typeId;
  final int price;
  final html.File? imagefile;

  const Item(
      {required this.id,
      required this.image,
      required this.typeId,
      required this.price,
      this.imagefile});

  @override
  List<Object?> get props => [id, image, typeId, price, imagefile];
}
