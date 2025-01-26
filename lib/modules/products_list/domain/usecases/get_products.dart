import '../../../../api/data_source.dart';
import '../../../product_details/domain/entities/product.dart';
import '../../data/datasource/products_datasource.dart';

final class GetProductsUC implements UseCase<List<Product>, NoParams> {
  final ProductsDataSource dataSource;

  const GetProductsUC(this.dataSource);

  @override
  UsecaseResult<List<Product>> call(NoParams params) async {
    try {
      return Right(
        (await dataSource.getProducts())
            .map(
              (product) => Product.from(product),
            )
            .toList(),
      );
    } on CacheException {
      return Left(CacheFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
