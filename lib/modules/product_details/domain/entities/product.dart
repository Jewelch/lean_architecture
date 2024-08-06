import 'package:lean_requester/models_exp.dart';

import '../../data/models/product_model.dart';

base class Product extends DTO {
  final String title;
  final String description;
  final num rating;
  final num price;
  final String thumbnail;

  const Product({
    required this.title,
    required this.description,
    required this.rating,
    required this.price,
    required this.thumbnail,
  });

  factory Product.from(ProductModel productModel) => Product(
        title: productModel.title ?? "",
        description: productModel.description ?? "",
        rating: productModel.rating ?? 0,
        price: productModel.price ?? 0,
        thumbnail: productModel.thumbnail ?? "",
      );
  @override
  List<Object?> get props => [title, description, price];
}
