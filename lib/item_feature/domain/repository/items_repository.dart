import 'package:alamri_adm/core/errors/failure.dart';
import 'package:alamri_adm/item_feature/domain/entities/item.dart';
import 'package:dartz/dartz.dart';

abstract class ItemsRepository {
  Future<Either<Failure, List<Item?>>> getItems();
  Future<Either<Failure, Map<String, dynamic>>> addItem(Item item);
  Future<Either<Failure, Map<String, dynamic>>> updateItem(Item item);
  Future<Either<Failure, Map<String, dynamic>>> deleteItem(Item item);
}
