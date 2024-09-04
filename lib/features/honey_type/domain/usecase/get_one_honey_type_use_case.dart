import 'package:alamri_adm/core/errors/failure.dart';
import 'package:alamri_adm/core/usecase/usecase.dart';
import 'package:alamri_adm/features/honey_type/domain/entities/type.dart';
import 'package:alamri_adm/features/honey_type/domain/repository/honey_type_repository.dart';
import 'package:dartz/dartz.dart';

class GetOneHoneyTypeUseCase implements Usecase<HoneyType, int> {
  final HoneyTypeRepository honeyTypeRepository;

  GetOneHoneyTypeUseCase({required this.honeyTypeRepository});

  @override
  Future<Either<Failure, HoneyType>> call(int params) async {
    return await honeyTypeRepository.getOneType(params);
  }
}
