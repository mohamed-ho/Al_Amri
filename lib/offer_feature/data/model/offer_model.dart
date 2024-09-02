import 'dart:convert';

import 'package:alamri_adm/offer_feature/data/model/types_and_quantities_model.dart';
import 'package:alamri_adm/offer_feature/domain/entities/offer.dart';

class OfferModel extends Offer {
  const OfferModel({
    required super.title,
    required super.description,
    required super.typesId,
    required super.price,
    required super.discount,
    required super.quantity,
    required super.image,
    super.imageFile,
    required super.id,
  });

  factory OfferModel.fromJson(
      Map<String, dynamic> offer, TypesAndQuantitiesModel typeAndquantity) {
    return OfferModel(
      id: offer['id'],
      title: offer['title'],
      description: offer['description'],
      typesId: typeAndquantity.typesId,
      price: offer['price'],
      discount: offer['discount'],
      quantity: typeAndquantity.quantities,
      image: offer['image'],
    );
  }

  factory OfferModel.fromOffer(Offer offer) {
    return OfferModel(
        title: offer.title,
        description: offer.description,
        typesId: offer.typesId,
        price: offer.price,
        discount: offer.discount,
        quantity: offer.quantity,
        image: offer.image,
        id: offer.id,
        imageFile: offer.imageFile);
  }

  Map<String, dynamic> toJoson() {
    return {
      'id': id,
      'title': title,
      'typeId': jsonEncode(typesId),
      'price': price,
      'discount': discount,
      'image': image,
      'description': description,
      'quantity': jsonEncode(quantity)
    };
  }
}
