import 'package:alamri_adm/admain_feature/data/data_source/honey_type_remote_data_source.dart';
import 'package:alamri_adm/admain_feature/data/models/honey_type_maodel.dart';
import 'package:alamri_adm/admain_feature/domain/entities/type.dart';
import 'package:alamri_adm/admain_feature/domain/repository/honey_type_repository.dart';
import 'package:alamri_adm/core/errors/exceptions.dart';
import 'package:alamri_adm/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

class HoneyTypeRepositoryImpl implements HoneyTypeRepository {
  final HoneyTypeRemoteDataSource honeyTypeRemoteDataSource;

  HoneyTypeRepositoryImpl({required this.honeyTypeRemoteDataSource});
  @override
  Future<Either<Failure, Map<String, dynamic>>> addType(HoneyType type) async {
    try {
      final result = await honeyTypeRemoteDataSource
          .addHoneyType(HoneyTypeMaodel.fromHoneyType(type));
      return right(result);
    } on ServerExceptions catch (e) {
      return Left(ServerFailure(message: e.message!));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> deleteType(int typeId) async {
    try {
      final result = await honeyTypeRemoteDataSource.deleteHoneyType(typeId);
      return right(result);
    } on ServerExceptions catch (e) {
      return left(ServerFailure(message: e.message!));
    }
  }

  @override
  Future<Either<Failure, List<HoneyType>>> getType() async {
    try {
      final result = await honeyTypeRemoteDataSource.getHoneyType();
      return right(result);
    } on ServerExceptions catch (e) {
      return left(ServerFailure(message: e.message!));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> updateType(
      HoneyType type) async {
    try {
      final result = await honeyTypeRemoteDataSource
          .updateHoneyType(HoneyTypeMaodel.fromHoneyType(type));
      return right(result);
    } on ServerExceptions catch (e) {
      return Left(ServerFailure(message: e.message!));
    }
  }

  @override
  Future<Either<Failure, HoneyType>> getOneType(int id) async {
    try {
      final result = await honeyTypeRemoteDataSource.getOneHoneyType(id);
      return Right(result);
    } on ServerExceptions catch (e) {
      return Left(ServerFailure(message: e.message!));
    }
  }

  @override
  Future<Either<Failure, List<HoneyType>>> getListOfHoneyTypes(
      List<int> honeyTypesIds) async {
    try {
      final result =
          await honeyTypeRemoteDataSource.getListOfHoneyType(honeyTypesIds);
      return Right(result);
    } on ServerExceptions catch (e) {
      return Left(ServerFailure(message: e.message!));
    }
  }
}
