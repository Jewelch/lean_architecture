import '../../../../../api/data_source.dart';
import '../../../common/models/product_model.dart';

part '../mock/products_mock.dart';

abstract interface class ProductsDataSource {
  /// Calls the https://dummyjson.com/products endpoint.
  DataSourceListResult<ProductModel> getProducts();
}

final class ProductsDataSourceImpl extends LeanRequesterConfig implements ProductsDataSource {
  ProductsDataSourceImpl({
    required Dio client,
    required CacheManager cacheManager,
    required ConnectivityMonitor connectivityMonitor,
  }) : super(client, cacheManager, connectivityMonitor);

  @override
  DataSourceListResult<ProductModel> getProducts() async => await futureListOf<ProductModel>(
        from: request(
          requirements: (
            dao: ProductModel(),
            asList: true,
            listKey: "products",
          ),
          method: RestfulMethods.get,
          path: "products",
          cachingKey: 'productsKey',
          mockingData: true
              ? {
                  "products": _productList,
                }
              : _productList,
          mockIt: true,
        ),
      );
}
