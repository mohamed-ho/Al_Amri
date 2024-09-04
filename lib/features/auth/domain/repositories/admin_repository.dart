import 'package:alamri_adm/core/errors/failure.dart';
import 'package:alamri_adm/features/auth/domain/entities/admin.dart';
import 'package:dartz/dartz.dart';

abstract class AdminRepository {
  Future<Either<Failure, bool>> login(Admin admin);
  Future<Either<Failure, void>> addUser(Admin admin);
  Future<Either<Failure, bool>> logout();
}
