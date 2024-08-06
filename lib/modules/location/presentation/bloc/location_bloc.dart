import 'package:cg_core_defs/location/location_plugin.dart';

import '../../../../base/bloc/exports.dart';
import '../../../../managers/location/location_manager.dart';
import 'location_events.dart';
import 'location_states.dart';

abstract class LocationBloc extends Bloc<LocationEvent, LocationStates> {
  LocationBloc(super.initialState);

  getUserLocation<T extends LocationEvent>(T event, Emitter<LocationStates> emit);
  openAppSettings<T extends LocationEvent>(T event, Emitter<LocationStates> emit);
}

final class LocationBlocImpl extends LocationBloc {
  final locationManager = get<LocationManager>();

  LocationBlocImpl() : super(Idle()) {
    on<GetLocation>(getUserLocation<GetLocation>);
    on<OpenAppSettings>(openAppSettings<OpenAppSettings>);
    locationManager.initialize();
  }

  @override
  getUserLocation<T extends LocationEvent>(T event, Emitter<LocationStates> emit) async {
    emit(Loading());

    final GeoCoordinates? userLocation = await locationManager.getUserCurrentLocation();

    emit(
      userLocation == null ? Error(message: "Couldn't get user position") : Success(geoCoordinates: userLocation),
    );
  }

  @override
  openAppSettings<T extends LocationEvent>(T event, Emitter<LocationStates> emit) {
    locationManager.openAppSettings();
  }
}
