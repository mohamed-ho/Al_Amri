part of 'honey_type_bloc.dart';

class HoneyTypeState extends Equatable {
  const HoneyTypeState();

  @override
  List<Object> get props => [];
}

final class HoneyTypeInitial extends HoneyTypeState {}

final class HoneyTypeLoading extends HoneyTypeState {}

final class HoneyTypeLoaded extends HoneyTypeState {
  final List<HoneyType> honeyType;

  const HoneyTypeLoaded({required this.honeyType});
  @override
  List<Object> get props => [honeyType];
}

final class HoneyTypeAddedState extends HoneyTypeState {
  final Map state;

  const HoneyTypeAddedState({required this.state});
  @override
  List<Object> get props => [state];
}

final class HoneyTypeError extends HoneyTypeState {
  final String message;

  const HoneyTypeError({required this.message});
  @override
  List<Object> get props => [message];
}

final class HoneyDeletedState extends HoneyTypeState {}

final class GetOneHoneyTypeState extends HoneyTypeState {
  final HoneyType honeyType;

  const GetOneHoneyTypeState({required this.honeyType});
  @override
  List<Object> get props => [honeyType];
}

final class GetListOfHoneyTypeState extends HoneyTypeState {
  final List<HoneyType> types;

  const GetListOfHoneyTypeState({required this.types});
  @override
  List<Object> get props => [types];
}
