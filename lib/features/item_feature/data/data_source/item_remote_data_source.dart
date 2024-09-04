import 'package:alamri_adm/features/honey_type/data/data_source/honey_type_remote_data_source.dart';
import 'package:alamri_adm/al_amri_enjection.dart';
import 'package:alamri_adm/core/apis/dio_consumer.dart';
import 'package:alamri_adm/core/apis/end_points.dart';
import 'package:alamri_adm/core/apis/http_consumer.dart';
import 'package:alamri_adm/features/item_feature/data/models/item_model.dart';

abstract class ItemRemoteDataSource {
  Future<List<ItemModel?>> getItems();
  Future<Map<String, dynamic>> updateItem(ItemModel item);
  Future<Map<String, dynamic>> addItem(ItemModel item);
  Future<Map<String, dynamic>> deleteItem(ItemModel item);
  Future<List<ItemModel>> getListOfItems(List<int> itemsId);
}

class ItemRemoteDataSourceImpl implements ItemRemoteDataSource {
  final DioConsumer dioConsumer;
  final HttpConsumer httpConsumer;
  ItemRemoteDataSourceImpl(
      {required this.dioConsumer, required this.httpConsumer});
  @override
  Future<Map<String, dynamic>> addItem(ItemModel item) async {
    try {
      await httpConsumer.uploadFileWithHTTP(
          url: EndPoints.addItem, selectedFile: item.imagefile!, item: item);
      return {'status': 'success'};
    } catch (e) {
      rethrow;
    }
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
    await httpConsumer.uploadFileWithHTTP(
        url: EndPoints.updateItem, selectedFile: item.imagefile!, item: item);
    return {'status': 'success'};
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
