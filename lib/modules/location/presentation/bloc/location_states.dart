import 'package:cg_core_defs/location/location_plugin.dart';
import 'package:equatable/equatable.dart';

sealed class LocationStates extends Equatable {
  @override
  List<Object> get props => [];
}

final class Idle extends LocationStates {}

final class Loading extends LocationStates {}

final class Empty extends LocationStates {}

final class Success extends LocationStates {
  final GeoCoordinates geoCoordinates;

  Success({required this.geoCoordinates});

  @override
  List<Object> get props => [geoCoordinates];
}

final class Error extends LocationStates {
  final String message;

  Error({required this.message});

  @override
  List<Object> get props => [message];
}
