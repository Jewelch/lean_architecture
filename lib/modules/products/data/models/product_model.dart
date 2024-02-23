import 'package:lean_requester/models_exp.dart';

import '../../domain/entities/product.dart';

final class ProductModel extends Product with DAO {
  final int? id;
  final int? stock;
  final List<String>? images;

  @override
  List<Object?> get props => [id, title, description, price];

  ProductModel({
    this.id,
    this.images,
    super.title,
    super.description,
    super.rating,
    this.stock,
    super.price,
    super.thumbnail,
  });

  factory ProductModel.fromJson(json) => ProductModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        rating: json['rating'],
        stock: json['stock'],
        price: json['price'],
        thumbnail: json['thumbnail'],
        images: (json['images'] as List<dynamic>).map((e) => e.toString()).toList(),
      );

  @override
  ProductModel fromJson(json) => ProductModel.fromJson(json);

  @override
  Map toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "rating": rating,
        "stock": stock,
        "price": price,
        "thumbnail": thumbnail,
        "images": images,
      };
}
