import 'package:equatable/equatable.dart';

class HoneyType extends Equatable {
  final int id;
  final String name;
  final int numberOfJar;
  final int jarQuantity;
  final String description;

  const HoneyType(
      {required this.id,
      required this.name,
      required this.numberOfJar,
      required this.jarQuantity,
      required this.description});

  @override
  List<Object?> get props => [id, name, numberOfJar, jarQuantity, description];
}
