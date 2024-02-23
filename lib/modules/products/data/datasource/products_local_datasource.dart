import 'package:shared_preferences/shared_preferences.dart';

import '../../../../api/data_source.dart';
import '../models/product_model.dart';

abstract interface class ProductLocalDataSource {
  static const key = 'cachedProductKey';

  Future<void> writeToCache(ProductModel product);
  Future<ProductModel> getProduct();
}

final class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final SharedPreferences sharedPreferences;

  const ProductLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<bool> writeToCache(ProductModel product) async => await sharedPreferences.setString(
        ProductLocalDataSource.key,
        jsonEncode(product.toJson()),
      );

  @override
  Future<ProductModel> getProduct() {
    final jsonString = sharedPreferences.getString(ProductLocalDataSource.key);
    if (jsonString != null) {
      return Future.value(ProductModel.fromJson(jsonDecode(jsonString)));
    } else {
      throw CacheException();
    }
  }
}
