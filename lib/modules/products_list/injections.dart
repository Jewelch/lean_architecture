import '../../app_dependencies.dart';
import 'data/datasource/products_datasource.dart';
import 'domain/usecases/get_products.dart';
import 'presentation/bloc/products_bloc.dart';

class ProductsDependencies {
  static void inject() {
    //? Bloc
    AppDependencies.di.registerFactory(() => ProductsBloc(get()));

    //@ Use cases
    AppDependencies.di.registerLazySingleton(() => GetProductsUC(get()));

    //$ Data sources
    AppDependencies.di.registerLazySingleton<ProductsDataSource>(
      () => ProductsDataSourceImpl(
        client: get(),
        cacheManager: get(),
        connectivityMonitor: get(),
      ),
    );
  }
}
