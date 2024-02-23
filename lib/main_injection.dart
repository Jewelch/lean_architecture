part of 'main.dart';

final sl = GetIt.instance;

class _Dependencies {
  static Future<void> inject() async {
    //? Bloc
    sl.registerFactory(() => ProductBloc(sl()));

    //@ Use cases
    sl.registerLazySingleton(() => GetProductByIdUC(sl()));

    //* Repositories
    sl.registerLazySingleton<ProductsRepository>(
      () => ProductsRepositoryImpl(
        localDataSource: sl(),
        connectivityManager: sl(),
        remoteDataSource: sl(),
      ),
    );

    //$ Data sources
    sl.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(client: sl()),
    );

    sl.registerLazySingleton<ProductLocalDataSource>(
      () => ProductLocalDataSourceImpl(sharedPreferences: sl()),
    );

    //! Core
    sl.registerLazySingleton<ConnectivityMonitor>(() => ConnectivityMonitorImpl(Connectivity()));

    //& External
    final sharedPreferences = await SharedPreferences.getInstance();

    sl.registerLazySingleton(() => sharedPreferences);
    sl.registerLazySingleton(() => Dio());
  }
}
