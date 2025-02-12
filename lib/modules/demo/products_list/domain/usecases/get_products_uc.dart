import '../../../../../api/data_source.dart';
import '../../../common/entities/product.dart';
import '../../../common/models/product_model.dart';
import '../../data/datasource/products_datasource.dart';

class GetProductsUC extends UseCase<Product, ProductModel, List<Product>> {
  GetProductsUC(ProductsDataSource dataSource)
      : super(
          dataSourceFetcher: (_) => dataSource.getProducts(),
          modelToEntityMapper: Product.from,
        );
}
