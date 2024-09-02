import 'package:alamri_adm/core/errors/failure.dart';
import 'package:alamri_adm/core/usecase/usecase.dart';
import 'package:alamri_adm/item_feature/domain/entities/item.dart';
import 'package:alamri_adm/item_feature/domain/repository/items_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteItemUsecase implements Usecase<Map<String, dynamic>, Item> {
  final ItemsRepository itemsRepository;

  DeleteItemUsecase({required this.itemsRepository});

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(Item params) async {
    return await itemsRepository.deleteItem(params);
  }
}
