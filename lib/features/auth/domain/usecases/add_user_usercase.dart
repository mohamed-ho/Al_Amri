import 'package:alamri_adm/core/errors/failure.dart';
import 'package:alamri_adm/core/usecase/usecase.dart';
import 'package:alamri_adm/features/auth/domain/entities/admin.dart';
import 'package:alamri_adm/features/auth/domain/repositories/admin_repository.dart';
import 'package:dartz/dartz.dart';

class AddUserUsercase implements Usecase<void, Admin> {
  final AdminRepository adminRepository;

  AddUserUsercase({required this.adminRepository});
  @override
  Future<Either<Failure, void>> call(Admin params) async {
    return await adminRepository.addUser(params);
  }
}
