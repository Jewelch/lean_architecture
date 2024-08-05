import '../../app_dependencies.dart';
import 'data/datasource/product_datasource.dart';
import 'domain/usecases/get_product_by_id.dart';
import 'presentation/bloc/product_bloc.dart';

class ProductScreenDependencies {
  static void inject() {
    //? Bloc
    AppDependencies.di.registerFactory(() => ProductDetailsBlocImpl(get()));

    //@ Use cases
    AppDependencies.di.registerLazySingleton(() => GetProductByIdUC(get()));

    //$ Data sources
    AppDependencies.di.registerLazySingleton<ProductDataSource>(
      () => ProductRemoteDataSourceImpl(
        client: get(),
        cacheManager: get(),
        connectivityMonitor: get(),
      ),
    );
  }
}
