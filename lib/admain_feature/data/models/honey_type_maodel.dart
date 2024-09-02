import 'package:alamri_adm/admain_feature/domain/entities/type.dart';

class HoneyTypeMaodel extends HoneyType {
  const HoneyTypeMaodel(
      {required super.id,
      required super.name,
      required super.numberOfJar,
      required super.jarQuantity,
      required super.description});

  factory HoneyTypeMaodel.fromJson(Map<String, dynamic> json) {
    return HoneyTypeMaodel(
        id: json['id'],
        name: json['name'],
        numberOfJar: json['number_of_jar'],
        jarQuantity: json['jar_quantity'],
        description: json['description']);
  }

  factory HoneyTypeMaodel.fromHoneyType(HoneyType type) {
    return HoneyTypeMaodel(
        id: type.id,
        name: type.name,
        numberOfJar: type.numberOfJar,
        jarQuantity: type.jarQuantity,
        description: type.description);
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "numberOfJar": numberOfJar,
      "quantityOfJar": jarQuantity
    };
  }
}
