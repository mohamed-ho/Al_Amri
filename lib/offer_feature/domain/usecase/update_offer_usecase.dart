import 'package:alamri_adm/core/errors/failure.dart';
import 'package:alamri_adm/core/usecase/usecase.dart';
import 'package:alamri_adm/offer_feature/domain/entities/offer.dart';
import 'package:alamri_adm/offer_feature/domain/repository/offer_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateOfferUsecase implements Usecase<Map<String, dynamic>, Offer> {
  final OfferRepository offerRepository;

  UpdateOfferUsecase({required this.offerRepository});

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(Offer params) async {
    return await offerRepository.updateOffer(params);
  }
}
