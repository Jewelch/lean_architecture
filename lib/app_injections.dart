import 'package:cg_core_defs/cg_core_defs.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_network_connectivity/flutter_network_connectivity.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lean_requester/lean_requester.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/settings/app_settings.dart';
import 'managers/cache/get_storage.dart';
import 'managers/cache/shared_preferences.dart';
import 'managers/connectivity/connectivity_plus.dart';
import 'managers/connectivity/flutter_network_connectivity.dart';
import 'managers/dependency/get_it_container.dart';
import 'managers/dependency/kiwi_conainer.dart';

T get<T extends Object>([_]) => AppInjections.di.get<T>();

abstract class AppInjections {
  static const dependencyContainerEnvValue = String.fromEnvironment("DependencyContainer");
  static const cacheManagerEnvValue = String.fromEnvironment("CacheManager");
  static const connectivityMonitorEnvValue = String.fromEnvironment("ConnectivityMonitor");

  //= DI Container
  static final DependecyInjectionContainer di = (dependencyContainerEnvValue == "get_it") ? GetItContainer() : Kiwi();

  //= Cache Manager
  static Future<void> _asynchronous() async => switch (cacheManagerEnvValue) {
        //? Shared Preferences
        "shar_pref" => () async {
            final sharedPreferences = await SharedPreferences.getInstance();
            di.registerLazySingleton(() => sharedPreferences);
            di.registerLazySingleton<CacheManager>(() => SharedPrefs());
          }.call(),
        //? GET Storage
        "get_storage" => () {
            final getSorage = GetStorage();
            di.registerLazySingleton(() => getSorage);
            di.registerLazySingleton<CacheManager>(() => GetStore());
          }.call(),
        _ => {
            throw UnimplementedError("$cacheManagerEnvValue Key not defined in IDE ToolArgs"),
          },
      };

  static _synchronous() async => {
        di.registerSingleton(AppSettings()),
        di.registerLazySingleton(() => Dio()),

        //= Connectivity Monitor
        switch (connectivityMonitorEnvValue) {
          //? ConnectivityPlus
          "connectivity_plus" => di.registerLazySingleton<ConnectivityMonitor>(() => ConnectivityPlus(Connectivity())),
          //? FlutterNetConnectivity
          "flutter_network_connectivity" => di.registerLazySingleton<ConnectivityMonitor>(() => FlutterNetConnectivity(
                FlutterNetworkConnectivity(
                  isContinousLookUp: true,
                  lookUpDuration: const Duration(seconds: 5),
                  lookUpUrl: "pub.dev",
                ),
              )),
          _ => {
              throw UnimplementedError("$connectivityMonitorEnvValue Key not defined in IDE ToolArgs"),
            },
        }
      };

  static Future<void> all() async => await _asynchronous().then((_) => _synchronous());
}
