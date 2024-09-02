import 'package:alamri_adm/admain_feature/data/data_source/honey_type_remote_data_source.dart';
import 'package:alamri_adm/al_amri_enjection.dart';
import 'package:alamri_adm/core/apis/dio_consumer.dart';
import 'package:alamri_adm/core/apis/end_points.dart';
import 'package:alamri_adm/features/orders/data/models/item_order_model.dart';
import 'package:alamri_adm/features/orders/data/models/order_model.dart';
import 'package:alamri_adm/item_feature/data/data_source/item_remote_data_source.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderModel>> getOrders();
  Future<void> deleteOrder(int orderId);
  Future<List<ItemOrderModel>?> getListOfItemOrders(List<int> itemsId);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final DioConsumer dioConsumer;

  OrderRemoteDataSourceImpl({required this.dioConsumer});
  @override
  Future<void> deleteOrder(int orderId) async {
    await dioConsumer.post(EndPoints.deleteOrder,
        body: {'id': orderId}, formDataIsEnabled: true);
  }

  @override
  Future<List<OrderModel>> getOrders() async {
    final result = await dioConsumer.get(EndPoints.getOrders);

    if (result.isEmpty) return [];
    return List<OrderModel>.from(result.map((e) => OrderModel.fromJson(e)));
  }

  @override
  Future<List<ItemOrderModel>?> getListOfItemOrders(List<int> itemsId) async {
    try {
      final listOfItems =
          await ls<ItemRemoteDataSource>().getListOfItems(itemsId);
      List<int> listOfTypesId = [];
      for (var e in listOfItems) {
        listOfTypesId.add(e.typeId);
      }
      final ListOfTypes = await ls<HoneyTypeRemoteDataSource>()
          .getListOfHoneyType(listOfTypesId);

      List<ItemOrderModel> itemOrder = [];
      for (int i = 0; i < listOfItems.length; i++) {
        itemOrder.add(ItemOrderModel(
            image: listOfItems[i].image,
            name: ListOfTypes[i].name,
            price: listOfItems[i].price,
            wieght: ListOfTypes[i].jarQuantity));
      }
      return itemOrder;
    } catch (e) {
      rethrow;
    }
  }
}
