part of 'orders_bloc.dart';

abstract class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object> get props => [];
}

class OrdersInitial extends OrdersState {}

class OrdersLoadingState extends OrdersState {}

class OrderErrorState extends OrdersState {
  final String message;
  const OrderErrorState({required this.message});
  @override
  List<Object> get props => [message];
}

class OrderLoadedState extends OrdersState {}

class OrderGetedState extends OrdersState {
  final List<Orders> orders;
  const OrderGetedState({required this.orders});
  @override
  List<Object> get props => [orders];
}

final class OrderGetedItemsOrderState extends OrdersState {
  final List<ItemOrder> itemOrder;
  const OrderGetedItemsOrderState({required this.itemOrder});
  @override
  List<Object> get props => [itemOrder];
}
