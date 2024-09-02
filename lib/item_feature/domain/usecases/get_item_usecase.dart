import 'package:alamri_adm/core/errors/failure.dart';
import 'package:alamri_adm/core/usecase/usecase.dart';
import 'package:alamri_adm/item_feature/domain/entities/item.dart';
import 'package:alamri_adm/item_feature/domain/repository/items_repository.dart';
import 'package:dartz/dartz.dart';

class GetItemUsecase implements Usecase<List<Item?>, NoParams> {
  final ItemsRepository itemsRepository;

  GetItemUsecase({required this.itemsRepository});
  @override
  Future<Either<Failure, List<Item?>>> call(NoParams params) async {
    return await itemsRepository.getItems();
  }
}
