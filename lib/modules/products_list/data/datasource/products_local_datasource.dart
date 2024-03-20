import 'package:shared_preferences/shared_preferences.dart';

import '../../../../api/data_source.dart';
import '../../../product_details/data/models/product_model.dart';

abstract interface class ProductsLocalDataSource {
  static const key = 'cachedProductsKey';

  Future<void> writeToCache(List<ProductModel>? product);
  List<ProductModel>? getProducts();
}

final class ProductsLocalDataSourceImpl implements ProductsLocalDataSource {
  final SharedPreferences sharedPreferences;

  const ProductsLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<bool> writeToCache(List<ProductModel>? products) async => await sharedPreferences.setString(
        ProductsLocalDataSource.key,
        jsonEncode(
          DaoList<ProductModel>(item: ProductModel(), key: "products", list: products).toJson(),
        ),
      );

  @override
  List<ProductModel>? getProducts() {
    final jsonString = sharedPreferences.getString(ProductsLocalDataSource.key);
    if (jsonString != null) {
      return DaoList(item: ProductModel(), key: "products").fromJson(jsonDecode(jsonString)).list;
    } else {
      throw CacheException();
    }
  }
}
