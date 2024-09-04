import 'package:alamri_adm/core/errors/failure.dart';
import 'package:alamri_adm/core/usecase/usecase.dart';
import 'package:alamri_adm/features/honey_type/domain/entities/type.dart';
import 'package:alamri_adm/features/honey_type/domain/repository/honey_type_repository.dart';
import 'package:dartz/dartz.dart';

class GetListOfHoneyTypeUsecase implements Usecase<List<HoneyType>, List<int>> {
  final HoneyTypeRepository honeyTypeRepository;

  GetListOfHoneyTypeUsecase({required this.honeyTypeRepository});
  @override
  Future<Either<Failure, List<HoneyType>>> call(List<int> params) async {
    return await honeyTypeRepository.getListOfHoneyTypes(params);
  }
}
