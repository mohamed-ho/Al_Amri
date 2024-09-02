import 'package:alamri_adm/core/errors/exceptions.dart';
import 'package:alamri_adm/core/errors/failure.dart';
import 'package:alamri_adm/item_feature/data/data_source/item_remote_data_source.dart';
import 'package:alamri_adm/item_feature/data/models/item_model.dart';
import 'package:alamri_adm/item_feature/domain/entities/item.dart';
import 'package:alamri_adm/item_feature/domain/repository/items_repository.dart';
import 'package:dartz/dartz.dart';

class ItemsRepositoryImpl implements ItemsRepository {
  final ItemRemoteDataSource itemRemoteDataSource;

  ItemsRepositoryImpl({required this.itemRemoteDataSource});
  @override
  Future<Either<Failure, Map<String, dynamic>>> addItem(Item item) async {
    try {
      final resut =
          await itemRemoteDataSource.addItem(ItemModel.fromItem(item));
      return Right(resut);
    } on ServerExceptions catch (e) {
      return Left(ServerFailure(message: e.message!));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> deleteItem(Item item) async {
    try {
      final result =
          await itemRemoteDataSource.deleteItem(ItemModel.fromItem(item));
      return Right(result);
    } on ServerExceptions catch (e) {
      return Left(ServerFailure(message: e.message!));
    }
  }

  @override
  Future<Either<Failure, List<Item?>>> getItems() async {
    try {
      final resut = await itemRemoteDataSource.getItems();
      return Right(resut);
    } on ServerExceptions catch (e) {
      return Left(ServerFailure(message: e.message!));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> updateItem(Item item) async {
    try {
      final resut =
          await itemRemoteDataSource.updateItem(ItemModel.fromItem(item));
      return Right(resut);
    } on ServerExceptions catch (e) {
      return Left(ServerFailure(message: e.message!));
    }
  }
}
