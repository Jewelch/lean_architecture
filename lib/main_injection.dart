part of 'main.dart';

final sl = GetIt.instance;

class _Dependencies {
  static Future<void> inject() async {
    sl.registerLazySingleton<ConnectivityMonitor>(() => ConnectivityMonitorImpl(Connectivity()));

    sl.registerLazySingleton(() => Dio());

    final sharedPreferences = await SharedPreferences.getInstance();

    sl.registerLazySingleton(() => sharedPreferences);
  }
}
