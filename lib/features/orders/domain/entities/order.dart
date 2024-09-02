class Orders {
  int? id;
  final String name;
  final String phone;
  final String email;
  final String gover;
  final String city;
  final String address;
  final int totalPrice;
  List<int>? itemsId;
  List<int>? offersId;
  List<int>? itemsQuantities;
  List<int>? offersQuantities;

  Orders(
      {required this.name,
      required this.phone,
      required this.email,
      required this.gover,
      required this.city,
      required this.address,
      required this.totalPrice,
      this.id,
      this.itemsId,
      this.itemsQuantities,
      this.offersId,
      this.offersQuantities});
}
