import 'package:alamri_adm/core/errors/failure.dart';
import 'package:alamri_adm/core/usecase/usecase.dart';
import 'package:alamri_adm/features/honey_type/domain/entities/type.dart';
import 'package:alamri_adm/features/honey_type/domain/repository/honey_type_repository.dart';
import 'package:dartz/dartz.dart';

class GetTypeUsecase implements Usecase<List<HoneyType>, NoParams> {
  final HoneyTypeRepository honeyTypeRepository;

  GetTypeUsecase({required this.honeyTypeRepository});

  @override
  Future<Either<Failure, List<HoneyType>>> call(NoParams params) async =>
      await honeyTypeRepository.getType();
}
