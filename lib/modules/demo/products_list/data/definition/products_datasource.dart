import '../../../../../api/data_source.dart';
import '../../../common/data_models/product_model.dart';

abstract interface class ProductsDataSource {
  /// Calls the https://dummyjson.com/products endpoint.
  DataSourceListResult<ProductModel> getProducts();
}
