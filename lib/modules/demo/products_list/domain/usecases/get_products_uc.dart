import '../../../../../api/data_source.dart';
import '../../../common/data_models/product_model.dart';
import '../../../common/domain_entities/product.dart';
import '../../data/definition/products_datasource.dart';

class GetProductsUC extends UseCase<Product, ProductModel, List<Product>> {
  GetProductsUC(ProductsDataSource dataSource)
      : super(
          dataSourceFetcher: (_) => dataSource.getProducts(),
          modelToEntityMapper: Product.from,
        );
}
