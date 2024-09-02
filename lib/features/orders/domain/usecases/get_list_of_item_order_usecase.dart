import 'package:alamri_adm/core/errors/failure.dart';
import 'package:alamri_adm/core/usecase/usecase.dart';
import 'package:alamri_adm/features/orders/domain/entities/item_order.dart';
import 'package:alamri_adm/features/orders/domain/repositories/order_repository.dart';
import 'package:dartz/dartz.dart';

class GetListOfItemOrderUsecase extends Usecase<List<ItemOrder>, List<int>> {
  final OrderRepository orderRepository;

  GetListOfItemOrderUsecase({required this.orderRepository});
  @override
  Future<Either<Failure, List<ItemOrder>>> call(List<int> params) async {
    return await orderRepository.getListOfItemOrder(params);
  }
}
