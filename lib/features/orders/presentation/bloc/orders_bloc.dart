import 'package:alamri_adm/core/usecase/usecase.dart';
import 'package:alamri_adm/features/orders/domain/entities/item_order.dart';
import 'package:alamri_adm/features/orders/domain/entities/order.dart';
import 'package:alamri_adm/features/orders/domain/usecases/delete_order_usecase.dart';
import 'package:alamri_adm/features/orders/domain/usecases/get_list_of_item_order_usecase.dart';
import 'package:alamri_adm/features/orders/domain/usecases/get_orders_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final GetOrdersUsecase getOrdersUsecase;
  final DeleteOrderUsecase deleteOrderUsecase;
  final GetListOfItemOrderUsecase getListOfItemOrderUsecase;
  OrdersBloc(
      {required this.deleteOrderUsecase,
      required this.getOrdersUsecase,
      required this.getListOfItemOrderUsecase})
      : super(OrdersInitial()) {
    on<GetOrdersEvent>((event, emit) async {
      emit(OrdersLoadingState());
      final result = await getOrdersUsecase(NoParams());
      result.fold((l) => emit(OrderErrorState(message: l.message)),
          (r) => emit(OrderGetedState(orders: r)));
    });
    on<GetItemOrderEvent>((event, emit) async {
      emit(OrdersLoadingState());
      final result = await getListOfItemOrderUsecase(event.itemsId);
      result.fold((l) => emit(OrderErrorState(message: l.message)),
          (r) => emit(OrderGetedItemsOrderState(itemOrder: r)));
    });

    on<DeleteOrderEvent>((event, emit) async {
      emit(OrdersLoadingState());
      final result = await deleteOrderUsecase(event.orderId);
      result.fold((l) => emit(OrderErrorState(message: l.message)),
          (r) => emit(OrderLoadedState()));
    });
  }
}
