part of 'honey_type_bloc.dart';

class HoneyTypeEvent extends Equatable {
  const HoneyTypeEvent();

  @override
  List<Object> get props => [];
}

final class AddHoneyTypeEvent extends HoneyTypeEvent {
  final HoneyType honeyType;

  const AddHoneyTypeEvent({required this.honeyType});
  @override
  List<Object> get props => [honeyType];
}

final class GetHoneyTypeEvent extends HoneyTypeEvent {}

final class DeleteHoneyTypeEven extends HoneyTypeEvent {
  final int honeyId;
  const DeleteHoneyTypeEven({required this.honeyId});
  @override
  List<Object> get props => [honeyId];
}

final class UpdateHoneyTypeEvent extends HoneyTypeEvent {
  final HoneyType honeyType;

  const UpdateHoneyTypeEvent({required this.honeyType});
  @override
  List<Object> get props => [honeyType];
}

final class GetOneHoneyTypeEvent extends HoneyTypeEvent {
  final int typeId;

  const GetOneHoneyTypeEvent({required this.typeId});
  @override
  List<Object> get props => [typeId];
}

final class GetListOfHoneyTypeEvent extends HoneyTypeEvent {
  final List<int> ids;

  const GetListOfHoneyTypeEvent({required this.ids});
  @override
  List<Object> get props => [ids];
}
