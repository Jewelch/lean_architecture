import '../../../../api/data_source.dart';
import '../../../product/domain/entities/product.dart';
import '../../data/datasource/products_datasource.dart';

final class GetProductsUC implements UseCase<List<Product>, NoParams> {
  final ProductsDataSource dataSource;

  const GetProductsUC(this.dataSource);

  @override
  UseCaseResult<List<Product>> call(NoParams params) async {
    try {
      return Right((await dataSource.getProducts()).map(Product.from).toList());
    } on CommonException catch (e) {
      return Left(Failure(message: e.message));
    }
  }
}
