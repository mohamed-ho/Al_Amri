import 'package:alamri_adm/admain_feature/domain/repository/honey_type_repository.dart';
import 'package:alamri_adm/core/errors/failure.dart';
import 'package:alamri_adm/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';

class DeleteHoneyTypeUsecase extends Usecase<Map<String, dynamic>, int> {
  final HoneyTypeRepository honeyTypeRepository;

  DeleteHoneyTypeUsecase({required this.honeyTypeRepository});
  @override
  Future<Either<Failure, Map<String, dynamic>>> call(int params) =>
      honeyTypeRepository.deleteType(params);
}
