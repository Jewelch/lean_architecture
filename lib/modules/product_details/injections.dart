import 'package:get_it/get_it.dart';

import 'data/datasource/product_local_datasource.dart';
import 'data/datasource/product_remote_datasource.dart';
import 'data/repository/products_repository_impl.dart';
import 'domain/repository/product_repository.dart';
import 'domain/usecases/get_product_by_id.dart';
import 'presentation/bloc/product_bloc.dart';

class ProductScreenDependencies {
  static final sl = GetIt.instance;

  static void inject() {
    //? Bloc
    sl.registerFactory(() => ProductDetailsBlocImpl(sl()));

    //@ Use cases
    sl.registerLazySingleton(() => GetProductByIdUC(sl()));

    //* Repositories
    sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(
        localDataSource: sl(),
        connectivityManager: sl(),
        remoteDataSource: sl(),
      ),
    );

    //$ Data sources
    sl.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(client: sl()),
    );

    sl.registerLazySingleton<ProductLocalDataSource>(
      () => ProductLocalDataSourceImpl(sharedPreferences: sl()),
    );
  }
}
