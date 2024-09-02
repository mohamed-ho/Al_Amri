import 'package:alamri_adm/al_amri_enjection.dart';
import 'package:alamri_adm/offer_feature/data/repository/offer_repository_impl.dart';
import 'package:alamri_adm/offer_feature/data/soutce_data/offer_remote_data_source.dart';
import 'package:alamri_adm/offer_feature/domain/repository/offer_repository.dart';
import 'package:alamri_adm/offer_feature/domain/usecase/add_offer_usercase.dart';
import 'package:alamri_adm/offer_feature/domain/usecase/delete_offer_usecase.dart';
import 'package:alamri_adm/offer_feature/domain/usecase/get_List_of_offers_usecase.dart';
import 'package:alamri_adm/offer_feature/domain/usecase/get_offfer_usecase.dart';
import 'package:alamri_adm/offer_feature/domain/usecase/update_offer_usecase.dart';
import 'package:alamri_adm/offer_feature/presentation/bloc/offer_bloc.dart';

class OfferInjection {
  void init() {
    ls.registerFactory(() => OfferBloc(
        getOffferUsecase: ls(),
        addOfferUsercase: ls(),
        updateOfferUsecase: ls(),
        deleteOfferUsecase: ls(),
        getListOfOffersUsecase: ls()));

    ls.registerLazySingleton(() => GetOffferUsecase(offerRepository: ls()));
    ls.registerLazySingleton(() => AddOfferUsercase(offerRepository: ls()));
    ls.registerLazySingleton(() => UpdateOfferUsecase(offerRepository: ls()));
    ls.registerLazySingleton(() => DeleteOfferUsecase(offerRepository: ls()));
    ls.registerLazySingleton(
        () => GetListOfOffersUsecase(offerRepository: ls()));

    ls.registerLazySingleton<OfferRepository>(
        () => OfferRepositoryImpl(offerRemoteDataSource: ls()));

    ls.registerLazySingleton<OfferRemoteDataSource>(
        () => OfferRemoteDataSourceImpl(dioConsumer: ls()));
  }
}
