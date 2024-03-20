import 'package:lean_requester/repository_exp.dart';

import '../../domain/repository/product_repository.dart';
import '../datasource/product_local_datasource.dart';
import '../datasource/product_remote_datasource.dart';
import '../models/product_model.dart';

final class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final ConnectivityMonitor connectivityManager;

  const ProductRepositoryImpl({
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
        return Right(localDataSource.getProduct());
      } catch (exception) {
        return Left(CacheFailure());
      }
    }
  }
}
