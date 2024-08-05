import 'package:cg_core_defs/helpers/debugging_printer.dart';
import 'package:cg_core_defs/location/location_plugin.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' hide LocationAccuracy;

final class LocationStrategy implements LocationPlugin {
  final _location = Location();

  @override
  Future<bool> hasPermission() async => [
        PermissionStatus.granted,
        PermissionStatus.grantedLimited,
      ].contains(await _location.hasPermission());

  @override
  Future<bool> requestPermission() async => [
        PermissionStatus.granted,
        PermissionStatus.grantedLimited,
      ].contains(await _location.requestPermission());

  @override
  Future<bool> serviceEnabled() => _location.serviceEnabled();

  @override
  Future<bool> requestService() => _location.requestService();

  @override
  Future<GeoCoordinates> getLocation() async {
    Debugger.red("Depending on $Geolocator package to get current position.");

    final locationData = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

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
