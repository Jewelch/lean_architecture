import 'dart:async';

import 'package:cg_core_defs/location/index.dart';
import 'package:geolocator/geolocator.dart';

import '../../app/app_widget.dart';
import '../../base/screens/exports.dart';

class LocationManager {
  final userCoordinatesObs = Observable<GeoCoordinates?>(null);
  final placeDetailsObs = Observable<PlaceDetail?>(null);
  final serviceEnabledObs = Observable<bool>(false);

  bool? _hasPermission;
  StreamSubscription<ServiceStatus>? localizationServiceStatusStreamSubscription;
  late final LocationPlugin _plugin;
  final int timeout;

  LocationManager(
    LocationPlugin locationPlugin, {
    this.timeout = 10,
  }) : _plugin = locationPlugin;

  Future<void> initialize() async {
    await getUserCurrentLocation();

    localizationServiceStatusStreamSubscription ??= Geolocator.getServiceStatusStream().listen((ServiceStatus status) async {
      if (status != ServiceStatus.enabled) {
        userCoordinatesObs.annihilate();
        placeDetailsObs.annihilate();
        serviceEnabledObs.disable();
        return;
      } else {
        await getUserCurrentLocation();
      }
    });
  }

  Future<GeoCoordinates?> getUserCurrentLocation() async {
    if (await (_locationPermissionGranted)) {
      return await _getCurrentLocation();
    } else {
      if (!(await _plugin.requestPermission())) {
        Notifier.locationPermissionNotGrantedSnackbar();
        return null;
      } else
        return await _getCurrentLocation();
    }
  }

  Future<bool> get _locationPermissionGranted async => _hasPermission ??= await _plugin.hasPermission();

  Future<bool> get _locationServiceEnabled async {
    serviceEnabledObs.value = await _plugin.serviceEnabled();

    if (!serviceEnabledObs.value) {
      serviceEnabledObs.value = await _plugin.requestService();
    }
    return serviceEnabledObs.value;
  }

  Future<GeoCoordinates?> _getCurrentLocation() async {
    if (await _locationServiceEnabled) {
      Debugger.green("$runtimeType getting location");

      await Future.any([
        _getCurrentPosition(),
        Future.delayed(Duration(seconds: timeout)),
      ]);

      return userCoordinatesObs.value;
    }
    return null;
  }

  Future<void> _getCurrentPosition() async => userCoordinatesObs.value = await _plugin.getLocation();

  Future<bool> openAppSettings() => _plugin.openAppSettings();
  Future<bool> openLocationSettings() => _plugin.openLocationSettings();
}

class Notifier {
  static Future<void> locationPermissionNotGrantedSnackbar() async {
    final scaffoldMessenger = ScaffoldMessenger.of(AppWidget.globalContext!);
    final snackBar = SnackBar(
      backgroundColor: AppColors.greyDark,
      content: Text(
        "Location permission is required to use this app.",
        style: AppStyles.subtitle.withColor(AppColors.scaffold),
      ),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 1500),
    );

    // Show the SnackBar and wait for its duration
    ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBarController = scaffoldMessenger.showSnackBar(snackBar);
    await snackBarController.closed;
  }
}
