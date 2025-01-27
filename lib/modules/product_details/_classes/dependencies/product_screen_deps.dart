import '../../../../app_injections.dart';
import '../../../../base/dependencies/dependencies.dart';
import '../../common/data/datasource/product_datasource.dart';
import '../../common/domain/usecases/get_product_by_id.dart';
import '../presentation/bloc/product_bloc.dart';

class ProductScreenDependencies implements Dependencies {
  @override
  void inject() {
    //? Bloc
    AppInjections.di.registerFactory(() => ProductDetailsBlocClasses());

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
