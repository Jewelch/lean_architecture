import '../../../../../api/data_source.dart';
import '../../../common/data_models/product_model.dart';
import '../definition/product_datasource.dart';

part '../mock/product_mock.dart';

final class ProductDataSourceImpl extends RestfulConsumerImpl implements ProductDataSource {
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
