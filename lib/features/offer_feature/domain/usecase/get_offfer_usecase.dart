import 'package:alamri_adm/core/errors/failure.dart';
import 'package:alamri_adm/core/usecase/usecase.dart';
import 'package:alamri_adm/features/offer_feature/domain/entities/offer.dart';
import 'package:alamri_adm/features/offer_feature/domain/repository/offer_repository.dart';
import 'package:dartz/dartz.dart';

class GetOffferUsecase implements Usecase<List<Offer?>, NoParams> {
  final OfferRepository offerRepository;

  GetOffferUsecase({required this.offerRepository});
  @override
  Future<Either<Failure, List<Offer?>>> call(NoParams params) async {
    return await offerRepository.getOffers();
  }
}
