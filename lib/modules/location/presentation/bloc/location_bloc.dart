import 'package:cg_core_defs/location/location_plugin.dart';

import '../../../../base/bloc/exports.dart';
import '../../../../managers/location/location_manager.dart';
import 'location_events.dart';
import 'location_states.dart';

final class LocationBloc extends BaseBloc<LocationEvent, LocationStates> {
  @override
  bool get debugginEnabled => false;

  final locationManager = get<LocationManager>();

  LocationBloc() : super(Idle()) {
    on<GetLocation>(getUserLocation);
    on<OpenAppSettings>(openAppSettings);
  }

  @override
  onReady() {
    locationManager.initialize();
    super.onReady();
  }

  getUserLocation(GetLocation event, Emitter<LocationStates> emit) async {
    emit(Loading());

    final GeoCoordinates? userLocation = await locationManager.getUserCurrentLocation();

    userLocation == null
        ? emit(Error(message: "Couldn't get user position"))
        : emit(Success(geoCoordinates: userLocation));
  }

  openAppSettings(OpenAppSettings event, Emitter<LocationStates> emit) =>
      locationManager.openAppSettings();
}
