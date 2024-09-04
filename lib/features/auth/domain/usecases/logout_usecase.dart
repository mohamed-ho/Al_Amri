import 'package:alamri_adm/core/errors/failure.dart';
import 'package:alamri_adm/core/usecase/usecase.dart';
import 'package:alamri_adm/features/auth/domain/repositories/admin_repository.dart';
import 'package:dartz/dartz.dart';

class LogoutUsecase implements Usecase<bool, NoParams> {
  final AdminRepository adminRepository;

  LogoutUsecase({required this.adminRepository});
  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await adminRepository.logout();
  }
}
