import 'package:alamri_adm/core/apis/dio_consumer.dart';
import 'package:alamri_adm/core/apis/end_points.dart';
import 'package:alamri_adm/item_feature/data/models/item_model.dart';

abstract class ItemRemoteDataSource {
  Future<List<ItemModel?>> getItems();
  Future<Map<String, dynamic>> updateItem(ItemModel item);
  Future<Map<String, dynamic>> addItem(ItemModel item);
  Future<Map<String, dynamic>> deleteItem(ItemModel item);
  Future<List<ItemModel>> getListOfItems(List<int> itemsId);
}

class ItemRemoteDataSourceImpl implements ItemRemoteDataSource {
  final DioConsumer dioConsumer;

  ItemRemoteDataSourceImpl({required this.dioConsumer});
  @override
  Future<Map<String, dynamic>> addItem(ItemModel item) async {
    final result = await dioConsumer.uplaodFile(
        url: EndPoints.addItem, file: item.imagefile!, body: item.toJson());
    return result;
  }

  @override
  Future<Map<String, dynamic>> deleteItem(ItemModel item) async {
    return await dioConsumer.post(EndPoints.deleteItem,
        body: item.toJson(), formDataIsEnabled: true);
  }

  @override
  Future<List<ItemModel?>> getItems() async {
    final resut = await dioConsumer.get(EndPoints.getItem);
    if (resut['data'] == 'fail') return [];
    return List<ItemModel>.from(
        resut['data'].map((e) => ItemModel.fromJson(e)));
  }

  @override
  Future<Map<String, dynamic>> updateItem(ItemModel item) async {
    if (item.imagefile == null) {
      return await dioConsumer.post(EndPoints.updateItem,
          body: item.toJson(), formDataIsEnabled: true);
    }
    return await dioConsumer.uplaodFile(
        url: EndPoints.updateItem, file: item.imagefile, body: item.toJson());
  }

  @override
  Future<List<ItemModel>> getListOfItems(List<int> itemsId) async {
    final result = await dioConsumer.post(EndPoints.getListOfItems,
        body: {'itemsId': itemsId.toString()}, formDataIsEnabled: true);
    if (result['data'] == 'fail') return [];
    return List<ItemModel>.from(
        result['data'].map((e) => ItemModel.fromJson(e)));
  }
}
