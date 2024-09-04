import 'package:equatable/equatable.dart';

class TypesAndQuantitiesModel extends Equatable {
  final List<int> typesId;
  final List<int> quantities;

  const TypesAndQuantitiesModel(
      {required this.typesId, required this.quantities});

  factory TypesAndQuantitiesModel.formJson(Map<String, dynamic> json) {
    return TypesAndQuantitiesModel(
        typesId: List<int>.from(json['types'].map((e) => e['id'])),
        quantities: List<int>.from(json['quantities'].map((e) => e)));
  }

  @override
  List<Object?> get props => [typesId, quantities];
}
