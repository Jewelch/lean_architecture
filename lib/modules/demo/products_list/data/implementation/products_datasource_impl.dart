import '../../../../../api/data_source.dart';
import '../../../common/data_models/product_model.dart';
import '../definition/products_datasource.dart';

part '../mock/products_mock.dart';

final class ProductsDataSourceImpl extends RestfulConsumerImpl implements ProductsDataSource {
  ProductsDataSourceImpl({
    required Dio client,
    required CacheManager cacheManager,
    required ConnectivityMonitor connectivityMonitor,
  }) : super(client, cacheManager, connectivityMonitor);

  @override
  DataSourceListResult<ProductModel> getProducts() async => request(
        requirements: (
          dao: ProductModel(),
          asList: true,
          listKey: "products",
        ),
        method: RestfulMethods.get,
        path: "products",
        cachingKey: 'productsKey',
        // mockIt: true,
        mockingData: false
            ? {
                "products": _productList,
              }
            : _productList,
      ).toListOf<ProductModel>();
}
