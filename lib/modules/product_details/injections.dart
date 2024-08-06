import '../../app_injections.dart';
import 'data/datasource/product_datasource.dart';
import 'domain/usecases/get_product_by_id.dart';
import 'presentation/bloc/product_bloc.dart';

class ProductScreenDependencies {
  static void inject() {
    //? Bloc
    AppInjections.di.registerFactory(() => ProductDetailsBlocImpl(get()));

    //@ Use cases
    AppInjections.di.registerLazySingleton(() => GetProductByIdUC(get()));

    //$ Data sources
    AppInjections.di.registerLazySingleton<ProductDataSource>(
      () => ProductRemoteDataSourceImpl(
        client: get(),
        cacheManager: get(),
        connectivityMonitor: get(),
      ),
    );
  }
}
