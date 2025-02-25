import '../../../../app_injections.dart';
import '../../../../base/dependencies/dependencies.dart';
import '../data/definition/products_datasource.dart';
import '../data/implementation/products_datasource_impl.dart';
import '../domain/usecases/get_products_uc.dart';
import '../presentation/bloc/products_bloc.dart';

class ProductsDependencies implements Dependencies {
  @override
  void inject() {
    //? Bloc
    AppInjections.di.registerFactory(() => ProductsBloc(get()));

    //@ Use cases
    AppInjections.di.registerLazySingleton(() => GetProductsUC(get()));

    //$ Data sources
    AppInjections.di.registerLazySingleton<ProductsDataSource>(
      () => ProductsDataSourceImpl(
        client: get(),
        cacheManager: get(),
        connectivityMonitor: get(),
      ),
    );
  }
}
