import 'dart:async';

import 'package:cg_core_defs/cg_core_defs.dart';
import 'package:kiwi/kiwi.dart';

class Kiwi extends DependecyInjectionContainer {
  @override
  KiwiContainer get actor => KiwiContainer();

  @override
  void registerInstance<T extends Object>(T instance, {String? name}) {
    if (isRegistered<T>(name: name)) return;
    actor.registerInstance(instance, name: name);
  }

  @override
  void registerFactory<T extends Object>(T Function() factoryFunc, {String? name}) {
    if (isRegistered<T>(name: name)) return;
    actor.registerFactory((c) => factoryFunc(), name: name);
  }

  @override
  void registerSingleton<T extends Object>(T instance, {String? name, bool? signalsReady, FutureOr Function(T p1)? dispose}) {
    if (isRegistered<T>(name: name)) return;
    actor.registerSingleton((c) => instance, name: name);
  }

  @override
  void registerLazySingleton<T extends Object>(T Function() factoryFunc, {String? name, FutureOr Function(T p1)? dispose}) {
    if (isRegistered<T>(name: name)) return;
    actor.registerSingleton((c) => factoryFunc(), name: name);
  }

  @override
  T get<T extends Object>() => actor.resolve<T>();

  @override
  T getNamed<T extends Object>(String name) => actor.resolve<T>(name);

  @override
  bool isRegistered<T extends Object>({String? name}) => actor.isRegistered<T>(name: name);

  @override
  void unregister<T extends Object>({String? name}) {
    if (isRegistered<T>(name: name)) actor.unregister<T>(name);
  }

  @override
  void clear() => actor.clear();
}
