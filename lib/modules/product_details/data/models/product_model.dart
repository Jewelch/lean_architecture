import 'package:lean_requester/models_exp.dart';

final class ProductModel implements DAO {
  final int? id;
  final int? stock;
  final String? title;
  final String? description;
  final num? rating;
  final num? price;
  final String? thumbnail;

  ProductModel({
    this.id,
    this.stock,
    this.title,
    this.description,
    this.rating,
    this.price,
    this.thumbnail,
  });

  @override
  ProductModel fromJson(json) => ProductModel(
        id: json?['id'],
        title: json?['title'],
        description: json?['description'],
        rating: json?['rating'],
        stock: json?['stock'],
        price: json?['price'],
        thumbnail: json?['thumbnail'],
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "rating": rating,
        "stock": stock,
        "price": price,
        "thumbnail": thumbnail,
      };
}
