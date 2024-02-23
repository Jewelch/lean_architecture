import 'package:lean_requester/models_exp.dart';

base class Product extends DTO {
  final String? title;
  final String? description;
  final num? rating;
  final num? price;
  final String? thumbnail;

  const Product({this.title, this.description, this.rating, this.price, this.thumbnail});

  @override
  List<Object?> get props => [title, description, price];
}
