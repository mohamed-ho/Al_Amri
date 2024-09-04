import 'dart:convert';
import 'dart:html' as html;
import 'package:alamri_adm/features/item_feature/data/models/item_model.dart';
import 'package:alamri_adm/features/offer_feature/data/model/offer_model.dart';
import 'package:http/http.dart' as http;
import 'package:alamri_adm/core/apis/end_points.dart';

class HttpConsumer {
  final String _basicAuth =
      'Basic ${base64Encode(utf8.encode('mohamed:mohamed110'))}';
  Map<String, String> myHeaders = {
    'authorization': 'Basic ${base64Encode(utf8.encode('mohamed:mohamed110'))}',
  };

  Future<void> uploadFileWithHTTP(
      {required String url,
      required html.File selectedFile,
      required ItemModel? item}) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(EndPoints.addItem), // Replace with your PHP endpoint
      );

      request.headers.addAll(myHeaders);
      if (item != null) {
        request.fields['typeId'] = item.typeId.toString();
        request.fields['price'] = item.price.toString();
      }
      final reader = html.FileReader();
      reader.readAsArrayBuffer(selectedFile);
      reader.onLoadEnd.listen((event) async {
        final bytes = reader.result as List<int>;
        request.files.add(
          http.MultipartFile.fromBytes(
            'imageFile',
            bytes,
            filename: selectedFile.name,
          ),
        );

        await request.send();
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> uploadOfferFile(
      {required String url, required OfferModel offer}) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(url), // Replace with your PHP endpoint
      );

      request.headers.addAll(myHeaders);

      request.fields['title'] = offer.title.toString();
      request.fields['typeId'] = jsonEncode(offer.typesId);
      request.fields['price'] = offer.price.toString();
      request.fields['discount'] = offer.discount.toString();
      request.fields['description'] = offer.description;
      request.fields['quantity'] = jsonEncode(offer.quantity);

      final reader = html.FileReader();
      reader.readAsArrayBuffer(offer.imageFile!);
      reader.onLoadEnd.listen((event) async {
        final bytes = reader.result as List<int>;
        request.files.add(
          http.MultipartFile.fromBytes(
            'imageFile',
            bytes,
            filename: offer.imageFile!.name,
          ),
        );

        await request.send();
      });
    } catch (e) {
      rethrow;
    }
  }
}
