import '../../base/extensions/di_ext.dart';
import 'data/datasource/product_datasource.dart';
import 'domain/usecases/get_product_by_id.dart';
import 'presentation/bloc/product_bloc.dart';

class ProductScreenDependencies {
  static final sl = GetIt.instance;

  static void inject() {
    //? Bloc
    sl.registerFactoryOnce(() => ProductDetailsBlocImpl(sl()));

    //@ Use cases
    sl.registerLazySingletonOnce(() => GetProductByIdUC(sl()));

    //$ Data sources
    sl.registerLazySingletonOnce<ProductDataSource>(
      () => ProductRemoteDataSourceImpl(client: sl(), cacheManager: sl()),
    );
  }
}
