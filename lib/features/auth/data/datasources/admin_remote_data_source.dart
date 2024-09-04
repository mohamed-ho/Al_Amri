import 'package:alamri_adm/core/apis/dio_consumer.dart';
import 'package:alamri_adm/core/apis/end_points.dart';
import 'package:alamri_adm/features/auth/data/models/admin_model.dart';

abstract class AdminRemoteDataSource {
  Future<bool> login(AdminModel admin);
  Future<void> addUser(AdminModel admin);
}

class AdminRemoteDataSourceImpl implements AdminRemoteDataSource {
  final DioConsumer dioConsumer;

  AdminRemoteDataSourceImpl({required this.dioConsumer});
  @override
  Future<bool> login(AdminModel admin) async {
    final result = await dioConsumer.post(EndPoints.login,
        body: admin.toJson(), formDataIsEnabled: true);
    return result['data'];
  }

  @override
  Future<void> addUser(AdminModel admin) async {
    await dioConsumer.post(EndPoints.addUser,
        body: admin.toJson(), formDataIsEnabled: true);
  }
}
