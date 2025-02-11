import '../../../../../api/data_source.dart';
import '../../../common/entities/product.dart';
import '../../../common/models/product_model.dart';
import '../../data/datasource/products_datasource.dart';

class GetProductsUC extends ListResultUseCase<Product, ProductModel, NoParams> {
  final ProductsDataSource dataSource;

  GetProductsUC(this.dataSource)
      : super(
          dataSourceEntry: (params) => dataSource.getProducts(),
          modelToEntityMapper: Product.from,
        );
}
