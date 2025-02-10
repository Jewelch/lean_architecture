import '../../../../api/data_source.dart';
import '../models/product_model.dart';

abstract interface class ProductDataSource {
  /// Calls the https://dummyjson.com/products/{id} endpoint.
  DataSourceSingleResult<ProductModel> getProductById(String id);
}

final class ProductDataSourceImpl extends LeanRequesterConfig implements ProductDataSource {
  ProductDataSourceImpl({
    required Dio client,
    required CacheManager cacheManager,
    required ConnectivityMonitor connectivityMonitor,
  }) : super(client, cacheManager, connectivityMonitor);

  @override
  DataSourceSingleResult<ProductModel> getProductById(String id) async => await request(
        requirement: ProductModel(),
        method: RestfulMethods.get,
        path: "products/$id",
        cachingKey: "productKey",
        mockingData: _mockProductData,
        mockIt: false,
      );

  Map<String, dynamic> get _mockProductData => {
        "id": 2,
        "title": "iPhone de Zahra",
        "description":
            "SIM-Free, Model A19211 6.5-inch Super Retina HD display with OLED technology A12 Bionic chip...",
        "price": 899,
        "rating": 4.44,
        "stock": 34,
        "thumbnail":
            "https://content.kaspersky-labs.com/fm/press-releases/fb/fbc851c5d96f312341ef4430d7052abb/processed/holding-iphone-3-q75.jpg",
      };
}
