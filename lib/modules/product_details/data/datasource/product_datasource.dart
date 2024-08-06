import '../../../../api/data_source.dart';
import '../models/product_model.dart';

abstract interface class ProductDataSource {
  /// Calls the https://dummyjson.com/products/{id} endpoint.
  DatasourceResult<ProductModel> getProductById(int id);
}

final class ProductRemoteDataSourceImpl extends LeanRequesterConfig implements ProductDataSource {
  ProductRemoteDataSourceImpl({
    required Dio client,
    required CacheManager cacheManager,
    required ConnectivityMonitor connectivityMonitor,
  }) : super(client, cacheManager, connectivityMonitor);

  @override
  DatasourceResult<ProductModel> getProductById(int id) async => await performDecodingRequest(
        // mockingEnabled: true,
        cachingKey: "productKey",
        path: "products/$id",
        method: RestfullMethods.get,
        dao: ProductModel(),
        mockingData: {
          "id": 2,
          "title": "iPhone de Zahra",
          "description": "SIM-Free, Model A19211 6.5-inch Super Retina HD display with OLED technology A12 Bionic chip with ...",
          "price": 899,
          "rating": 4.44,
          "stock": 34,
          "thumbnail":
              "https://content.kaspersky-labs.com/fm/press-releases/fb/fbc851c5d96f312341ef4430d7052abb/processed/holding-iphone-3-q75.jpg",
          "images": [
            "https://i.dummyjson.com/data/products/2/1.jpg",
            "https://i.dummyjson.com/data/products/2/2.jpg",
            "https://i.dummyjson.com/data/products/2/3.jpg",
          ]
        },
      );
}
