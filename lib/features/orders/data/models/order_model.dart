import 'dart:convert';

import 'package:alamri_adm/features/orders/domain/entities/order.dart';

class OrderModel extends Orders {
  OrderModel(
      {required super.name,
      required super.phone,
      required super.email,
      required super.gover,
      required super.city,
      required super.address,
      required super.totalPrice,
      super.id,
      super.itemsId,
      super.itemsQuantities,
      super.offersId,
      super.offersQuantities});

  factory OrderModel.formOrder(Orders order) {
    return OrderModel(
        name: order.name,
        phone: order.phone,
        email: order.email,
        gover: order.gover,
        city: order.city,
        address: order.address,
        totalPrice: order.totalPrice,
        id: order.id,
        itemsId: order.itemsId,
        itemsQuantities: order.itemsQuantities,
        offersId: order.offersId,
        offersQuantities: order.offersQuantities);
  }

  static List<int>? _convertFromStringToListOfInt(String list) {
    if (jsonDecode(list) == null) return null;
    List<int> result = [];
    List<dynamic> listOfDynamic = jsonDecode(list);
    for (var e in listOfDynamic) {
      result.add(e);
    }
    return result;
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
        name: json['name'],
        phone: json['phone'],
        email: json['email'],
        gover: json['gover'],
        city: json['city'],
        address: json['address'],
        totalPrice: json['totalPrice'],
        id: json['id'],
        itemsId: _convertFromStringToListOfInt(json['items_id']),
        itemsQuantities:
            _convertFromStringToListOfInt(json['items_quantities']),
        offersId: _convertFromStringToListOfInt(json['offers_id']),
        offersQuantities:
            _convertFromStringToListOfInt(json['offers_quantities']));
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "phone": phone,
      "email": email,
      "gover": gover,
      "city": city,
      "address": address,
      "itemsId": jsonEncode(itemsId),
      "itemsQuantities": jsonEncode(itemsQuantities),
      "offersId": jsonEncode(offersId),
      "offersQuantities": jsonEncode(offersQuantities),
      "totalPrice": totalPrice
    };
  }
}
