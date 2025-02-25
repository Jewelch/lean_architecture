import '../../../../../api/data_source.dart';
import '../../../common/data_models/product_model.dart';

abstract interface class ProductDataSource {
  /// Calls the https://dummyjson.com/products/{id} endpoint.
  DataSourceSingleResult<ProductModel> getProductById(String id);
}
