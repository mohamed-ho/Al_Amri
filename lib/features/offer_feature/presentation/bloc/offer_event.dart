part of 'offer_bloc.dart';

sealed class OfferEvent extends Equatable {
  const OfferEvent();

  @override
  List<Object> get props => [];
}

class GetOfferEvent extends OfferEvent {}

class AddOfferEvent extends OfferEvent {
  final Offer offer;

  const AddOfferEvent({required this.offer});
  @override
  List<Object> get props => [offer];
}

class UpdateOfferEvent extends OfferEvent {
  final Offer offer;

  const UpdateOfferEvent({required this.offer});
  @override
  List<Object> get props => [offer];
}

class DeleteOfferEvent extends OfferEvent {
  final Offer offer;

  const DeleteOfferEvent({required this.offer});
  @override
  List<Object> get props => [offer];
}

class GetListOfOffersEvent extends OfferEvent {
  final List<int> offerId;

  const GetListOfOffersEvent({required this.offerId});
  @override
  List<Object> get props => [offerId];
}
