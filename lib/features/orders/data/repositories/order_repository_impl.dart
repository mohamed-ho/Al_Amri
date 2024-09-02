import 'package:alamri_adm/core/errors/exceptions.dart';
import 'package:alamri_adm/core/errors/failure.dart';
import 'package:alamri_adm/features/orders/data/datasources/order_remote_data_source.dart';
import 'package:alamri_adm/features/orders/domain/entities/item_order.dart';
import 'package:alamri_adm/features/orders/domain/entities/order.dart';
import 'package:alamri_adm/features/orders/domain/repositories/order_repository.dart';
import 'package:dartz/dartz.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource orderRemoteDataSource;

  OrderRepositoryImpl({required this.orderRemoteDataSource});
  @override
  Future<Either<Failure, void>> deleteOrder(int orderId) async {
    try {
      final result = await orderRemoteDataSource.deleteOrder(orderId);
      return Right(result);
    } on ServerExceptions catch (e) {
      return Left(ServerFailure(message: e.message!));
    }
  }

  @override
  Future<Either<Failure, List<Orders>>> getOrders() async {
    try {
      final result = await orderRemoteDataSource.getOrders();
      return Right(result);
    } on ServerExceptions catch (e) {
      return Left(ServerFailure(message: e.message!));
    }
  }

  @override
  Future<Either<Failure, List<ItemOrder>>> getListOfItemOrder(
      List<int> itemsId) async {
    try {
      final result = await orderRemoteDataSource.getListOfItemOrders(itemsId);
      return Right(result!);
    } on ServerExceptions catch (e) {
      return Left(ServerFailure(message: e.message!));
    }
  }
}
