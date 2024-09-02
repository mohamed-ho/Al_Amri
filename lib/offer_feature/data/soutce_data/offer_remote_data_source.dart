import 'package:alamri_adm/core/apis/dio_consumer.dart';
import 'package:alamri_adm/core/apis/end_points.dart';
import 'package:alamri_adm/offer_feature/data/model/offer_model.dart';
import 'package:alamri_adm/offer_feature/data/model/types_and_quantities_model.dart';

abstract class OfferRemoteDataSource {
  Future<List<OfferModel>> getOffer();
  Future<TypesAndQuantitiesModel> getTypesAndQuantities(int offerId);
  Future<Map<String, dynamic>> addOffer(OfferModel offer);
  Future<Map<String, dynamic>> updateOffer(OfferModel offer);
  Future<Map<String, dynamic>> deleteOffer(OfferModel offer);
  Future<List<OfferModel>> getListOfOffers(List<int> offersId);
}

class OfferRemoteDataSourceImpl implements OfferRemoteDataSource {
  final DioConsumer dioConsumer;

  OfferRemoteDataSourceImpl({required this.dioConsumer});
  @override
  Future<Map<String, dynamic>> addOffer(OfferModel offer) async {
    return await dioConsumer.uplaodFile(
        url: EndPoints.addOffer, body: offer.toJoson(), file: offer.imageFile);
  }

  @override
  Future<Map<String, dynamic>> deleteOffer(OfferModel offer) async {
    return await dioConsumer.post(EndPoints.deleteOffer,
        body: offer.toJoson(), formDataIsEnabled: true);
  }

  @override
  Future<List<OfferModel>> getOffer() async {
    final result = await dioConsumer.get(EndPoints.getOffers);
    // Collect all the futures
    List<OfferModel> offerModels = [];
    for (int i = 0; i < result['data'].length; i++) {
      TypesAndQuantitiesModel typesAndQuantitiesModel =
          await getTypesAndQuantities(result['data'][i]['id']);
      offerModels
          .add(OfferModel.fromJson(result['data'][i], typesAndQuantitiesModel));
    }
    return offerModels;
  }

  @override
  Future<Map<String, dynamic>> updateOffer(OfferModel offer) async {
    if (offer.imageFile == null) {
      print(offer.toJoson());
      final result = await dioConsumer.post(EndPoints.updateOffer,
          body: offer.toJoson(), formDataIsEnabled: true);

      return result;
    }
    return await dioConsumer.uplaodFile(
        url: EndPoints.updateOffer,
        body: offer.toJoson(),
        file: offer.imageFile);
  }

  @override
  Future<TypesAndQuantitiesModel> getTypesAndQuantities(int offerId) async {
    final result = await dioConsumer.post(EndPoints.getTypesAndQuantities,
        body: {'id': offerId}, formDataIsEnabled: true);
    return TypesAndQuantitiesModel.formJson(result);
  }

  @override
  Future<List<OfferModel>> getListOfOffers(List<int> offersId) async {
    final result = await dioConsumer.post(EndPoints.getListOfOffers,
        body: {'offersId': offersId.toString()}, formDataIsEnabled: true);
    // Collect all the futures
    List<OfferModel> offerModels = [];
    for (int i = 0; i < result['data'].length; i++) {
      TypesAndQuantitiesModel typesAndQuantitiesModel =
          await getTypesAndQuantities(result['data'][i]['id']);
      offerModels
          .add(OfferModel.fromJson(result['data'][i], typesAndQuantitiesModel));
    }
    return offerModels;
  }
}
