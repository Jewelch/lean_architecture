import '../../base/extensions/di_ext.dart';
import 'data/datasource/products_datasource.dart';
import 'domain/usecases/get_products.dart';
import 'presentation/bloc/products_bloc.dart';

class ProductsDependencies {
  static final sl = GetIt.instance;

  static void inject() {
    //? Bloc
    sl.registerFactoryOnce(() => ProductsBloc(sl()));

    //@ Use cases
    sl.registerLazySingletonOnce(() => GetProductsUC(sl()));

    //$ Data sources
    sl.registerLazySingletonOnce<ProductsDataSource>(
      () => ProductsDataSourceImpl(client: sl(), cacheManager: sl(), connectivityManager: sl()),
    );
  }
}
