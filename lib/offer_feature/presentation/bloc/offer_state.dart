part of 'offer_bloc.dart';

sealed class OfferState extends Equatable {
  const OfferState();

  @override
  List<Object> get props => [];
}

final class OfferInitial extends OfferState {}

final class OfferErrorState extends OfferState {
  final String message;

  const OfferErrorState({required this.message});
  @override
  List<Object> get props => [message];
}

final class OfferLoadingState extends OfferState {}

final class OfferGetDataState extends OfferState {
  final List<Offer?> offers;

  const OfferGetDataState({required this.offers});
  @override
  List<Object> get props => [offers];
}

final class OfferLoadedState extends OfferState {
  final Map<String, dynamic> result;

  const OfferLoadedState({required this.result});
  @override
  List<Object> get props => [result];
}
