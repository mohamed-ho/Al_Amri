import 'package:alamri_adm/core/errors/failure.dart';
import 'package:alamri_adm/core/usecase/usecase.dart';

import 'package:alamri_adm/features/orders/domain/repositories/order_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteOrderUsecase extends Usecase<void, int> {
  final OrderRepository orderRepository;

  DeleteOrderUsecase({required this.orderRepository});
  @override
  Future<Either<Failure, void>> call(int params) async {
    return await orderRepository.deleteOrder(params);
  }
}
