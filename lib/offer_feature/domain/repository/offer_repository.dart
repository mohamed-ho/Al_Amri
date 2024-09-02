import 'package:alamri_adm/core/errors/failure.dart';
import 'package:alamri_adm/offer_feature/domain/entities/offer.dart';
import 'package:dartz/dartz.dart';

abstract class OfferRepository {
  Future<Either<Failure, List<Offer?>>> getOffers();
  Future<Either<Failure, Map<String, dynamic>>> addOffer(Offer offer);
  Future<Either<Failure, Map<String, dynamic>>> updateOffer(Offer offer);
  Future<Either<Failure, Map<String, dynamic>>> deleteOffer(Offer offer);
  Future<Either<Failure, List<Offer>>> getListOfOffers(List<int> offerId);
}
