import '../../app_dependencies.dart';
import '../../managers/location/geo_locator.dart';
import '../../managers/location/location.dart';
import '../../managers/location/location_manager.dart';
import 'presentation/bloc/location_bloc.dart';

class LocationScreenDependencies {
  static const locationManagerEnvValue = String.fromEnvironment("locationManager");

  static void inject() {
    //? Bloc
    AppDependencies.di.registerFactory(() => LocationBlocImpl());

    //= Location Manager
    AppDependencies.di.registerLazySingleton(
      () => LocationManager(
        locationManagerEnvValue == "geo_locator" ? GeolocatorStrategy() : LocationStrategy(),
      ),
    );
  }
}
