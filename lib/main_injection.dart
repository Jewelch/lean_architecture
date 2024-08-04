part of 'main.dart';

final sl = GetIt.instance;

class _Dependencies {
  static Future<void> _asynchronous() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => sharedPreferences);
    sl.registerLazySingleton<CacheManager>(() => CacheManagerImpl());
  }

  static _synchronous() async {
    sl.registerSingleton<ConnectivityManager>(ConnectivityManagerImpl(Connectivity()));

    sl.registerLazySingleton(() => Dio());
  }

  static Future<void> all() async => await _asynchronous().then((_) => _synchronous());
}

class CacheManagerImpl implements CacheManager {
  @override
  String? getString(String key) => sl.call<SharedPreferences>().getString(key);

  @override
  Future<bool> setString(String key, String value) => sl.call<SharedPreferences>().setString(key, value);
}
