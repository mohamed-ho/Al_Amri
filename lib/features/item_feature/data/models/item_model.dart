import 'package:alamri_adm/features/item_feature/domain/entities/item.dart';

class ItemModel extends Item {
  const ItemModel(
      {required super.id,
      required super.image,
      required super.typeId,
      required super.price,
      super.imagefile});
  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
        id: json['id'],
        image: json['image'],
        typeId: json['type_id'],
        price: json['price']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'image': image, 'typeId': typeId, 'price': price};
  }

  factory ItemModel.fromItem(Item item) {
    return ItemModel(
        id: item.id,
        image: item.image,
        typeId: item.typeId,
        price: item.price,
        imagefile: item.imagefile);
  }
}
