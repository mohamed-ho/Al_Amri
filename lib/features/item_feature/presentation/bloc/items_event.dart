part of 'items_bloc.dart';

sealed class ItemsEvent extends Equatable {
  const ItemsEvent();

  @override
  List<Object> get props => [];
}

final class InitEvent extends ItemsEvent {}

final class GetItemsEvent extends ItemsEvent {}

final class UpdateItemEvent extends ItemsEvent {
  final Item item;

  const UpdateItemEvent({required this.item});
  @override
  List<Object> get props => [item];
}

final class DeleteItemEvent extends ItemsEvent {
  final Item item;

  const DeleteItemEvent({required this.item});
  @override
  List<Object> get props => [item];
}

final class AddItemEvent extends ItemsEvent {
  final Item item;

  const AddItemEvent({required this.item});
  @override
  List<Object> get props => [item];
}
