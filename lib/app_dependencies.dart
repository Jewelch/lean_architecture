import 'package:cg_core_defs/cg_core_defs.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_network_connectivity/flutter_network_connectivity.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lean_requester/lean_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'managers/cache/get_storage.dart';
import 'managers/cache/shared_preferences.dart';
import 'managers/connectivity/connectivity_plus.dart';
import 'managers/connectivity/flutter_network_connectivity.dart';
import 'managers/dependency/get_it_container.dart';
import 'managers/dependency/kiwi_conainer.dart';

abstract class AppDependencies {
  static const dependencyContainerEnvValue = String.fromEnvironment("DependencyContainer");
  static const cacheManagerEnvValue = String.fromEnvironment("CacheManager");
  static const connectivityMonitorEnvValue = String.fromEnvironment("connectivityMonitor");

  //= DI Container
  static final DependecyInjectionContainer di = (dependencyContainerEnvValue == "get_it") ? GetItContainer() : Kiwi();

  //= Cache Manager
  static Future<void> _asynchronous() async {
    if (cacheManagerEnvValue == "shar_pref") {
      //$ Shared Preferences
      final sharedPreferences = await SharedPreferences.getInstance();
      di.registerLazySingleton(() => sharedPreferences);
      di.registerLazySingleton<CacheManager>(() => SharedPrefs());
    } else if (cacheManagerEnvValue == "get_storage") {
      //! GET Storage
      await GetStorage.init();

      final getSorage = GetStorage();
      di.registerLazySingleton(() => getSorage);
      di.registerLazySingleton<CacheManager>(() => GetStore());
    } else {
      throw UnimplementedError("CacheManager Key not defined in IDE ToolArgs");
    }
  }

  static _synchronous() async {
    //= Connectivity Monitor
    di.registerSingleton<ConnectivityMonitor>(
      connectivityMonitorEnvValue == "connectivity_plus"
          ? ConnectivityPlus(Connectivity())
          : FlutterNetConnectivity(
              FlutterNetworkConnectivity(
                isContinousLookUp: true,
                lookUpDuration: const Duration(seconds: 5),
                lookUpUrl: "pub.dev",
              ),
            ),
    );

    di.registerLazySingleton(() => Dio());
  }

  static Future<void> all() async => await _asynchronous().then((_) => _synchronous());
}

T get<T extends Object>() => AppDependencies.di.get<T>();
