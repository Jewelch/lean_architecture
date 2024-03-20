import 'package:get_it/get_it.dart';

import 'data/datasource/products_local_datasource.dart';
import 'data/datasource/products_remote_datasource.dart';
import 'data/repository/products_repository_impl.dart';
import 'domain/repository/products_repository.dart';
import 'domain/usecases/get_products.dart';
import 'presentation/bloc/products_bloc.dart';

extension GetItSafe on GetIt {
  //? FACTORY
  void registerFactoryOnce<T extends Object>(
    FactoryFunc<T> factoryFunc, {
    String? instanceName,
  }) {
    if (GetIt.instance.isRegistered<T>()) return;
    GetIt.instance.registerFactory(() => factoryFunc.call(), instanceName: instanceName);
  }

  void registerFactoryAsyncOnce<T extends Object>(
    FactoryFuncAsync<T> factoryFunc, {
    String? instanceName,
  }) {
    if (GetIt.instance.isRegistered<T>()) return;
    GetIt.instance.registerFactoryAsync(() => factoryFunc.call(), instanceName: instanceName);
  }

  //! SINGLETON

  void registerSingletonWithDependenciesOnce<T extends Object>(
    FactoryFunc<T> factoryFunc, {
    String? instanceName,
    Iterable<Type>? dependsOn,
    bool? signalsReady,
    DisposingFunc<T>? dispose,
  }) {
    {
      if (GetIt.instance.isRegistered<T>()) return;
      GetIt.instance.registerSingletonWithDependencies(
        () => factoryFunc.call(),
        instanceName: instanceName,
        dependsOn: dependsOn,
        signalsReady: signalsReady,
        dispose: dispose,
      );
    }
  }

  //$ LAZY SINGLETON
  void registerLazySingletonOnce<T extends Object>(
    FactoryFunc<T> factoryFunc, {
    String? instanceName,
    DisposingFunc<T>? dispose,
  }) {
    if (GetIt.instance.isRegistered<T>()) return;
    GetIt.instance.registerLazySingleton(() => factoryFunc.call(), instanceName: instanceName, dispose: dispose);
  }

  void registerLazySingletonAsyncOnce<T extends Object>(
    FactoryFuncAsync<T> factoryFunc, {
    String? instanceName,
    DisposingFunc<T>? dispose,
  }) {
    if (GetIt.instance.isRegistered<T>()) return;
    GetIt.instance.registerLazySingletonAsync(() => factoryFunc.call(), instanceName: instanceName, dispose: dispose);
  }
}

class ProductsDependencies {
  static final sl = GetIt.instance;

  static void inject() {
    //? Bloc
    sl.registerFactoryOnce(() => ProductsBloc(sl()));

    //@ Use cases
    sl.registerLazySingletonOnce(() => GetProductsUC(sl()));

    //* Repositories
    sl.registerLazySingletonOnce<ProductsRepository>(
      () => ProductsRepositoryImpl(
        localDataSource: sl(),
        connectivityManager: sl(),
        remoteDataSource: sl(),
      ),
    );

    //$ Data sources
    sl.registerLazySingletonOnce<ProductsRemoteDataSource>(
      () => ProductsRemoteDataSourceImpl(client: sl()),
    );

    sl.registerLazySingletonOnce<ProductsLocalDataSource>(
      () => ProductsLocalDataSourceImpl(sharedPreferences: sl()),
    );
  }
}
