import 'package:alamri_adm/admain_feature/data/models/honey_type_maodel.dart';
import 'package:alamri_adm/core/apis/dio_consumer.dart';
import 'package:alamri_adm/core/apis/end_points.dart';

abstract class HoneyTypeRemoteDataSource {
  Future<List<HoneyTypeMaodel>> getHoneyType();
  Future<Map<String, dynamic>> addHoneyType(HoneyTypeMaodel type);
  Future<Map<String, dynamic>> updateHoneyType(HoneyTypeMaodel type);
  Future<Map<String, dynamic>> deleteHoneyType(int id);
  Future<HoneyTypeMaodel> getOneHoneyType(int id);
  Future<List<HoneyTypeMaodel>> getListOfHoneyType(List<int> ids);
}

class HoneyTypeRemoteDataSourceImpl implements HoneyTypeRemoteDataSource {
  final DioConsumer dioConsumer;

  HoneyTypeRemoteDataSourceImpl({required this.dioConsumer});
  @override
  Future<Map<String, dynamic>> addHoneyType(HoneyTypeMaodel type) async {
    return await dioConsumer.post(EndPoints.addHoneyType,
        body: type.toJson(), formDataIsEnabled: true);
  }

  @override
  Future<Map<String, dynamic>> deleteHoneyType(int id) async {
    return await dioConsumer.post(EndPoints.deleteHoneyType,
        formDataIsEnabled: true, body: {'id': id});
  }

  @override
  Future<List<HoneyTypeMaodel>> getHoneyType() async {
    final response = await dioConsumer.get(EndPoints.getHoneyType);
    return List<HoneyTypeMaodel>.from(
        response['data'].map((e) => HoneyTypeMaodel.fromJson(e)));
  }

  @override
  Future<Map<String, dynamic>> updateHoneyType(HoneyTypeMaodel type) async {
    return await dioConsumer.post(EndPoints.updateHoneyType,
        body: type.toJson(), formDataIsEnabled: true);
  }

  @override
  Future<HoneyTypeMaodel> getOneHoneyType(int id) async {
    final result = await dioConsumer.post(EndPoints.getOneHoneyType,
        body: {'id': id}, formDataIsEnabled: true);
    return HoneyTypeMaodel.fromJson(result);
  }

  @override
  Future<List<HoneyTypeMaodel>> getListOfHoneyType(List<int> ids) async {
    final result = await dioConsumer.post(EndPoints.getListOfHoneyType,
        body: {'typeIds': ids.toString()}, formDataIsEnabled: true);
    return List<HoneyTypeMaodel>.from(
        result['data'].map((e) => HoneyTypeMaodel.fromJson(e)));
  }
}
