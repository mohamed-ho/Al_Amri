import 'package:alamri_adm/core/usecase/usecase.dart';
import 'package:alamri_adm/offer_feature/domain/entities/offer.dart';
import 'package:alamri_adm/offer_feature/domain/usecase/add_offer_usercase.dart';
import 'package:alamri_adm/offer_feature/domain/usecase/delete_offer_usecase.dart';
import 'package:alamri_adm/offer_feature/domain/usecase/get_List_of_offers_usecase.dart';
import 'package:alamri_adm/offer_feature/domain/usecase/get_offfer_usecase.dart';
import 'package:alamri_adm/offer_feature/domain/usecase/update_offer_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'offer_event.dart';
part 'offer_state.dart';

class OfferBloc extends Bloc<OfferEvent, OfferState> {
  final GetOffferUsecase getOffferUsecase;
  final AddOfferUsercase addOfferUsercase;
  final UpdateOfferUsecase updateOfferUsecase;
  final DeleteOfferUsecase deleteOfferUsecase;
  final GetListOfOffersUsecase getListOfOffersUsecase;
  OfferBloc(
      {required this.getOffferUsecase,
      required this.addOfferUsercase,
      required this.updateOfferUsecase,
      required this.deleteOfferUsecase,
      required this.getListOfOffersUsecase})
      : super(OfferInitial()) {
    on<GetOfferEvent>(
      (event, emit) async {
        emit(OfferLoadingState());
        final result = await getOffferUsecase(NoParams());
        result.fold((l) => emit(OfferErrorState(message: l.message)),
            (r) => emit(OfferGetDataState(offers: r)));
      },
    );

    on<UpdateOfferEvent>((event, emit) async {
      emit(OfferLoadingState());
      final result = await updateOfferUsecase(event.offer);
      result.fold((l) => emit(OfferErrorState(message: l.message)), (r) {
        if (r['state'] != 'success') {
          return emit(OfferErrorState(message: "${r['state ']} while process"));
        }
        return emit(OfferLoadedState(result: r));
      });
    });

    on<AddOfferEvent>((event, emit) async {
      emit(OfferLoadingState());
      final result = await addOfferUsercase(event.offer);
      result.fold((l) => emit(OfferErrorState(message: l.message)), (r) {
        if (r['state'] != 'success') {
          return emit(OfferErrorState(message: "${r['state ']} while process"));
        }
        return emit(OfferLoadedState(result: r));
      });
    });

    on<DeleteOfferEvent>((event, emit) async {
      final result = await deleteOfferUsecase(event.offer);
      result.fold((l) => emit(OfferErrorState(message: l.message)), (r) {
        if (r['status'] != 'success') {
          print('this is resutlt = $r');
          return emit(OfferErrorState(message: "${r['status']} while process"));
        }
        return emit(OfferLoadedState(result: r));
      });
    });

    on<GetListOfOffersEvent>(
      (event, emit) async {
        emit(OfferLoadingState());
        final result = await getListOfOffersUsecase(event.offerId);
        result.fold((l) => emit(OfferErrorState(message: l.message)),
            (r) => emit(OfferGetDataState(offers: r)));
      },
    );
  }
}
