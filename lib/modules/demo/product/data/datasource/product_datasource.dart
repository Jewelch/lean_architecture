import '../../../../../api/data_source.dart';
import '../../../common/models/product_model.dart';

part '../mock/product_mock.dart';

abstract interface class ProductDataSource {
  /// Calls the https://dummyjson.com/products/{id} endpoint.
  DataSourceSingleResult<ProductModel> getProductById(String id);
}

final class ProductDataSourceImpl extends RestfulConsumer implements ProductDataSource {
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
        mockingData: _mockProductData,
        // mockIt: true,
      );
}
