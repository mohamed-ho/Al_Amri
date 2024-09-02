part of 'orders_bloc.dart';

abstract class OrdersEvent extends Equatable {
  const OrdersEvent();

  @override
  List<Object> get props => [];
}

final class GetOrdersEvent extends OrdersEvent {}

final class DeleteOrderEvent extends OrdersEvent {
  final int orderId;
  const DeleteOrderEvent({required this.orderId});
  @override
  List<Object> get props => [orderId];
}

final class GetItemOrderEvent extends OrdersEvent {
  final List<int> itemsId;

  const GetItemOrderEvent({required this.itemsId});
  @override
  List<Object> get props => [itemsId];
}
