import 'package:alamri_adm/core/errors/exceptions.dart';
import 'package:alamri_adm/core/errors/failure.dart';
import 'package:alamri_adm/offer_feature/data/model/offer_model.dart';
import 'package:alamri_adm/offer_feature/data/soutce_data/offer_remote_data_source.dart';
import 'package:alamri_adm/offer_feature/domain/entities/offer.dart';
import 'package:alamri_adm/offer_feature/domain/repository/offer_repository.dart';
import 'package:dartz/dartz.dart';

class OfferRepositoryImpl implements OfferRepository {
  final OfferRemoteDataSource offerRemoteDataSource;

  OfferRepositoryImpl({required this.offerRemoteDataSource});
  @override
  Future<Either<Failure, Map<String, dynamic>>> addOffer(Offer offer) async {
    try {
      final result =
          await offerRemoteDataSource.addOffer(OfferModel.fromOffer(offer));
      return Right(result);
    } on ServerExceptions catch (e) {
      return Left(ServerFailure(message: e.message!));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> deleteOffer(Offer offer) async {
    try {
      final result =
          await offerRemoteDataSource.deleteOffer(OfferModel.fromOffer(offer));
      return Right(result);
    } on ServerExceptions catch (e) {
      return Left(ServerFailure(message: e.message!));
    }
  }

  @override
  Future<Either<Failure, List<Offer?>>> getOffers() async {
    try {
      final result = await offerRemoteDataSource.getOffer();
      return Right(result);
    } on ServerExceptions catch (e) {
      return Left(ServerFailure(message: e.message!));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> updateOffer(Offer offer) async {
    try {
      final result =
          await offerRemoteDataSource.updateOffer(OfferModel.fromOffer(offer));
      return Right(result);
    } on ServerExceptions catch (e) {
      return Left(ServerFailure(message: e.message!));
    }
  }

  @override
  Future<Either<Failure, List<Offer>>> getListOfOffers(
      List<int> offerId) async {
    try {
      final result = await offerRemoteDataSource.getListOfOffers(offerId);
      return Right(result);
    } on ServerExceptions catch (e) {
      return Left(ServerFailure(message: e.message!));
    }
  }
}
