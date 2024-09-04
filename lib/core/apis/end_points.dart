import 'package:flutter/foundation.dart';

class EndPoints {
  static const String baseURL = 'https://alamri.whf.bz/Al_Amri/';
  static const String honeyType = '${baseURL}types/';
  static const String getHoneyType = '${honeyType}get_type.php';
  static const String addHoneyType = '${honeyType}add_type.php';
  static const String updateHoneyType = '${honeyType}update_type.php';
  static const String deleteHoneyType = '${honeyType}delete_type.php';
  static const String getOneHoneyType = '${honeyType}get_one_type.php';
  static const String getListOfHoneyType = '${honeyType}get_list_of_types.php';

  static const String item = '${baseURL}items/';
  static const String addItem = '${item}add_item.php';
  static const String getItem = '${item}get_item.php';
  static const String updateItem = '${item}update_item.php';
  static const String deleteItem = '${item}delete_item.php';
  static const String getListOfItems = '${item}get_list_of_items.php';

  static const String imageRoot = '${baseURL}upload/';

  static const String offer = "${baseURL}offers/";

  static const String getOffers = '${offer}get_offer.php';
  static const String getTypesAndQuantities =
      '${offer}get_types_and_quantities.php';
  static const String updateOffer = '${offer}update_offer.php';
  static const String addOffer = '${offer}add_offer.php';
  static const String deleteOffer = '${offer}delete_offer.php';
  static const String getListOfOffers = '${offer}get_list_of_offers.php';

  //----------------- orders
  static const String orders = '${baseURL}orders/';
  static const String getOrders = '${orders}get_orders.php';
  static const String deleteOrder = '${orders}delete_order.php';

  //-----------------------admin
  static const String admin = '${baseURL}admin/';
  static const String login = '${admin}login.php';
  static const String addUser = '${admin}add_user.php';
}
