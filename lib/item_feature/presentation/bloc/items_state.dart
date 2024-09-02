part of 'items_bloc.dart';

sealed class ItemsState extends Equatable {
  const ItemsState();

  @override
  List<Object> get props => [];
}

final class ItemsInitial extends ItemsState {}

final class ItemsErrorState extends ItemsState {
  final String message;
  const ItemsErrorState({required this.message});
  @override
  List<Object> get props => [message];
}

final class ItemsGetedState extends ItemsState {
  final List<Item?> items;

  const ItemsGetedState({required this.items});
  @override
  List<Object> get props => [items];
}

final class ItemsLoadingState extends ItemsState {}

final class ItmesLoadedState extends ItemsState {
  final Map<String, dynamic> result;

  const ItmesLoadedState({required this.result});
  @override
  List<Object> get props => [result];
}
