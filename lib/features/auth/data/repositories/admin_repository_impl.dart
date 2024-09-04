import 'package:alamri_adm/core/errors/exceptions.dart';
import 'package:alamri_adm/core/errors/failure.dart';
import 'package:alamri_adm/features/auth/data/datasources/admin_remote_data_source.dart';
import 'package:alamri_adm/features/auth/data/models/admin_model.dart';
import 'package:alamri_adm/features/auth/domain/entities/admin.dart';
import 'package:alamri_adm/features/auth/domain/repositories/admin_repository.dart';
import 'package:dartz/dartz.dart';

class AdminRepositoryImpl extends AdminRepository {
  final AdminRemoteDataSource adminRemoteDataSource;

  AdminRepositoryImpl({required this.adminRemoteDataSource});
  @override
  Future<Either<Failure, void>> addUser(Admin admin) async {
    try {
      final result =
          await adminRemoteDataSource.addUser(AdminModel.fromAdmin(admin));
      return Right(result);
    } on ServerExceptions catch (e) {
      return Left(ServerFailure(message: e.message!));
    }
  }

  @override
  Future<Either<Failure, bool>> login(Admin admin) async {
    try {
      final result =
          await adminRemoteDataSource.login(AdminModel.fromAdmin(admin));
      return Right(result);
    } on ServerExceptions catch (e) {
      return Left(ServerFailure(message: e.message!));
    }
  }

  @override
  Future<Either<Failure, bool>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
