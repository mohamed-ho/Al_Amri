import 'package:alamri_adm/core/apis/dio_consumer.dart';
import 'package:alamri_adm/core/apis/end_points.dart';
import 'package:alamri_adm/core/apis/http_consumer.dart';
import 'package:alamri_adm/features/offer_feature/data/model/offer_model.dart';
import 'package:alamri_adm/features/offer_feature/data/model/types_and_quantities_model.dart';

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
  final HttpConsumer httpConsumer;
  OfferRemoteDataSourceImpl(
      {required this.dioConsumer, required this.httpConsumer});
  @override
  Future<Map<String, dynamic>> addOffer(OfferModel offer) async {
    await httpConsumer.uploadOfferFile(url: EndPoints.addOffer, offer: offer);
    return {'state': 'success'};
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
      final result = await dioConsumer.post(EndPoints.updateOffer,
          body: offer.toJoson(), formDataIsEnabled: true);

      return result;
    }
    await httpConsumer.uploadOfferFile(
        url: EndPoints.updateOffer, offer: offer);
    return {'state': 'success'};
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
