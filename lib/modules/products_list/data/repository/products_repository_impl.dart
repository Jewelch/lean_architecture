import 'package:lean_requester/repository_exp.dart';

import '../../../product_details/data/models/product_model.dart';
import '../../domain/repository/products_repository.dart';
import '../datasource/products_local_datasource.dart';
import '../datasource/products_remote_datasource.dart';

final class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsRemoteDataSource remoteDataSource;
  final ProductsLocalDataSource localDataSource;
  final ConnectivityMonitor connectivityManager;

  const ProductsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.connectivityManager,
  });

  @override
  RepositoryResult<List<ProductModel>?> getProducts() async {
    if (connectivityManager.isConnected) {
      try {
        final product = await remoteDataSource.getProducts();
        localDataSource.writeToCache(product);
        return Right(product);
      } catch (exception) {
        return Left(ServerFailure());
      }
    } else {
      try {
        return Right(localDataSource.getProducts());
      } catch (exception) {
        return Left(CacheFailure());
      }
    }
  }
}
