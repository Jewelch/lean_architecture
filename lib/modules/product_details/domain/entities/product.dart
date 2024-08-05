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
        title: productModel.title.safe(),
        description: productModel.description.safe(),
        rating: productModel.rating.safe(),
        price: productModel.price.safe(),
        thumbnail: productModel.thumbnail.safe(),
      );
  @override
  List<Object?> get props => [title, description, price];
}

extension NotNull on dynamic {
  dynamic safe() {
    if (this != null) return this;

    switch (runtimeType) {
      case num:
        return 15;
      case int:
        return 17;
      case String:
        return "18";
    }
  }
}
