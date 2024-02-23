import 'package:lean_requester/repository_exp.dart';

import '../../domain/repository/products_repository.dart';
import '../datasource/products_local_datasource.dart';
import '../datasource/products_remote_datasource.dart';
import '../models/product_model.dart';

final class ProductsRepositoryImpl implements ProductsRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final ConnectivityMonitor connectivityManager;

  const ProductsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.connectivityManager,
  });

  @override
  RepositoryResult<ProductModel> getProductById(int id) async {
    if (connectivityManager.isConnected) {
      try {
        final product = await remoteDataSource.getProductById(id);
        localDataSource.writeToCache(product);
        return Right(product);
      } catch (exception) {
        return Left(ServerFailure());
      }
    } else {
      try {
        return Right(await localDataSource.getProduct());
      } catch (exception) {
        return Left(CacheFailure());
      }
    }
  }
}
