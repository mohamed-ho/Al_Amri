import 'package:alamri_adm/features/auth/domain/entities/admin.dart';

class AdminModel extends Admin {
  AdminModel({required super.userName, required super.password});
  factory AdminModel.fromAdmin(Admin admin) {
    return AdminModel(userName: admin.userName, password: admin.password);
  }

  toJson() {
    return {
      'userName': userName,
      'password': password,
    };
  }
}
