import 'package:alamri_adm/core/errors/failure.dart';
import 'package:alamri_adm/core/usecase/usecase.dart';
import 'package:alamri_adm/features/orders/domain/entities/order.dart';
import 'package:alamri_adm/features/orders/domain/repositories/order_repository.dart';
import 'package:dartz/dartz.dart';

class GetOrdersUsecase extends Usecase<List<Orders>, void> {
  final OrderRepository orderRepository;

  GetOrdersUsecase({required this.orderRepository});
  @override
  Future<Either<Failure, List<Orders>>> call(void params) async {
    return await orderRepository.getOrders();
  }
}
