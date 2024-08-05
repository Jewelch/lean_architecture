import 'package:equatable/equatable.dart';

sealed class LocationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class GetLocation extends LocationEvent {}

final class OpenAppSettings extends LocationEvent {}
