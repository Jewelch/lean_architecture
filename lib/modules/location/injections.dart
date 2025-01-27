import '../../app_injections.dart';
import '../../base/dependencies/dependencies.dart';
import '../../managers/location/geo_locator.dart';
import '../../managers/location/location.dart';
import '../../managers/location/location_manager.dart';
import 'presentation/bloc/location_bloc.dart';

class LocationScreenDependencies implements Dependencies {
  static const locationManagerEnvValue = String.fromEnvironment("locationManager");

  @override
  void inject() {
    //? Bloc
    AppInjections.di.registerFactory(() => LocationBloc());

    //= Location Manager
    AppInjections.di.registerLazySingleton(
      () => LocationManager(
        locationManagerEnvValue == "geo_locator" ? GeolocatorStrategy() : LocationStrategy(),
      ),
    );
  }
}
