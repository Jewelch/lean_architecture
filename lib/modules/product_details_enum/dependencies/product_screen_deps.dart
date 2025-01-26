import '../../../../app_injections.dart';
import '../../../../base/dependencies/dependencies.dart';
import '../../product_details/data/datasource/product_datasource.dart';
import '../../product_details/domain/usecases/get_product_by_id.dart';
import '../presentation/bloc/product_bloc.dart';

class ProductScreenDependencies implements Dependencies {
  @override
  void inject() {
    //? Bloc
    AppInjections.di.registerFactory(() => ProductDetailsBlocEnum());

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
