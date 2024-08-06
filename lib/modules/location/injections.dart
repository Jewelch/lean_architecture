import '../../app_injections.dart';
import '../../managers/location/geo_locator.dart';
import '../../managers/location/location.dart';
import '../../managers/location/location_manager.dart';
import 'presentation/bloc/location_bloc.dart';

class LocationScreenDependencies {
  static const locationManagerEnvValue = String.fromEnvironment("locationManager");

  static void inject() {
    //? Bloc
    AppInjections.di.registerFactory(() => LocationBlocImpl());

    //= Location Manager
    AppInjections.di.registerLazySingleton(
      () => LocationManager(
        locationManagerEnvValue == "geo_locator" ? GeolocatorStrategy() : LocationStrategy(),
      ),
    );
  }
}
