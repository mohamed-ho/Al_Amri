import 'package:alamri_adm/core/errors/failure.dart';
import 'package:alamri_adm/core/usecase/usecase.dart';
import 'package:alamri_adm/offer_feature/domain/entities/offer.dart';
import 'package:alamri_adm/offer_feature/domain/repository/offer_repository.dart';
import 'package:dartz/dartz.dart';

class GetListOfOffersUsecase implements Usecase<List<Offer>, List<int>> {
  final OfferRepository offerRepository;

  GetListOfOffersUsecase({required this.offerRepository});
  @override
  Future<Either<Failure, List<Offer>>> call(List<int> params) async {
    return await offerRepository.getListOfOffers(params);
  }
}
