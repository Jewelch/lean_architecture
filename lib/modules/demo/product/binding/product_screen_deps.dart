import '../../../../app_injections.dart';
import '../../../../base/dependencies/dependencies.dart';
import '../data/definition/product_datasource.dart';
import '../data/implementation/product_datasource_impl.dart';
import '../domain/usecases/get_product_by_id.dart';
import '../presentation/bloc/product_bloc.dart';

class ProductScreenDependencies implements Dependencies {
  @override
  void inject() {
    //? Bloc
    AppInjections.di.registerFactory(() => ProductDetailsBloc());

    //@ Use cases
    AppInjections.di.registerLazySingleton(() => GetProductByIdUC(get()));

    //$ Data sources
    AppInjections.di.registerLazySingleton<ProductDataSource>(
      () => ProductDataSourceImpl(
        client: get(),
        cacheManager: get(),
        connectivityMonitor: get(),
      ),
    );
  }
}
