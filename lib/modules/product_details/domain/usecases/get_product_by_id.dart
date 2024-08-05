import 'package:lean_requester/lean_interceptor.dart';

import '../../data/datasource/product_datasource.dart';
import '../../data/models/product_model.dart';
import '../entities/product.dart';

class GetProductByIdUC implements UseCase<Product, Params> {
  final ProductDataSource dataSource;

  const GetProductByIdUC(this.dataSource);

  @override
  UsecaseResult<Product> call(Params params) async {
    try {
      final ProductModel product = await dataSource.getProductById(params.id);
      return Right(Product.from(product));
    } on CacheException {
      return Left(CacheFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}

final class Params extends Equatable {
  final int id;

  const Params({required this.id});

  @override
  List<Object> get props => [id];
}
