import 'package:alamri_adm/admain_feature/domain/entities/type.dart';
import 'package:alamri_adm/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

abstract class HoneyTypeRepository {
  Future<Either<Failure, List<HoneyType>>> getType();
  Future<Either<Failure, Map<String, dynamic>>> addType(HoneyType type);
  Future<Either<Failure, Map<String, dynamic>>> updateType(HoneyType type);
  Future<Either<Failure, Map<String, dynamic>>> deleteType(int typeId);
  Future<Either<Failure, HoneyType>> getOneType(int id);
  Future<Either<Failure, List<HoneyType>>> getListOfHoneyTypes(
      List<int> honeyTypesIds);
}
