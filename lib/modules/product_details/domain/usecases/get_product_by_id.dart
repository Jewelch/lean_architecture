import 'package:lean_requester/lean_interceptor.dart';

import '../../data/datasource/product_datasource.dart';
import '../entities/product.dart';

class GetProductByIdUC implements UseCase<Product, Params> {
  final ProductDataSource dataSource;

  const GetProductByIdUC(this.dataSource);

  @override
  UsecaseResult<Product> call(Params params) async {
    try {
      return Right(
        Product.from(
          await dataSource.getProductById(params.id),
        ),
      );
    } on CacheException {
      return Left(CacheFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}

final class Params extends Equatable {
  final String id;

  const Params({required this.id});

  @override
  List<Object> get props => [id];
}
