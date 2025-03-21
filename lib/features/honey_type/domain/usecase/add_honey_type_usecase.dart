import 'package:alamri_adm/core/errors/failure.dart';
import 'package:alamri_adm/core/usecase/usecase.dart';
import 'package:alamri_adm/features/honey_type/domain/entities/type.dart';
import 'package:alamri_adm/features/honey_type/domain/repository/honey_type_repository.dart';
import 'package:dartz/dartz.dart';

class AddHoneyTypeUsecase extends Usecase<Map<String, dynamic>, HoneyType> {
  final HoneyTypeRepository honeyTypeRepository;

  AddHoneyTypeUsecase({required this.honeyTypeRepository});
  @override
  Future<Either<Failure, Map<String, dynamic>>> call(HoneyType params) async =>
      honeyTypeRepository.addType(params);
}
