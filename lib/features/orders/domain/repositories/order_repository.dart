import 'package:alamri_adm/core/errors/failure.dart';
import 'package:alamri_adm/features/orders/domain/entities/item_order.dart';
import 'package:alamri_adm/features/orders/domain/entities/order.dart';
import 'package:dartz/dartz.dart';

abstract class OrderRepository {
  Future<Either<Failure, List<Orders>>> getOrders();
  Future<Either<Failure, void>> deleteOrder(int orderId);
  Future<Either<Failure, List<ItemOrder>>> getListOfItemOrder(
      List<int> itemsId);
}
