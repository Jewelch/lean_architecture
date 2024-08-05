import 'package:cg_core_defs/helpers/debugging_printer.dart';
import 'package:cg_core_defs/location/location_plugin.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:location/location.dart' hide LocationAccuracy;

final class GeolocatorStrategy implements LocationPlugin {
  final _location = Location();

  @override
  Future<bool> hasPermission() async => [
        LocationPermission.always,
        LocationPermission.whileInUse,
      ].contains(await Geolocator.checkPermission());

  @override
  Future<bool> requestPermission() async => [
        LocationPermission.always,
        LocationPermission.whileInUse,
      ].contains(await Geolocator.requestPermission());

  @override
  Future<bool> serviceEnabled() => Geolocator.isLocationServiceEnabled();

  @override
  Future<bool> requestService() {
    Debugger.red("Depending on $Location package to enable Location Service");
    return _location.requestService();
  }

  @override
  Future<GeoCoordinates> getLocation() async {
    final locationData = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
      forceAndroidLocationManager: GetPlatform.isAndroid,
    );

    return GeoCoordinates(
      locationData.latitude,
      locationData.longitude,
    );
  }

  @override
  Future<bool> openAppSettings() => GeolocatorPlatform.instance.openAppSettings();

  @override
  Future<bool> openLocationSettings() => GeolocatorPlatform.instance.openLocationSettings();
}
