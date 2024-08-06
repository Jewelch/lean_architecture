import 'package:cg_core_defs/location/location_plugin.dart';
import 'package:flutter/material.dart';

abstract final class AppConstants {
  static const mapDefaultCentralPoint = GeoCoordinates(41.7023892, -86.2341526);

  //$ Default Radius
  static const double defaultRadius = 3;

  //$ Default Elevation
  static const double defaultElevation = 8;

  static const scaffold = _Scaffold();
  static const inputs = _Inputs._();
  static const buttons = _Buttons._();
  static const drawer = _Drawer._();
  static final topBar = _TopBar._();
  static final bottomBar = _BottomBar._();
  static const cards = _Cards._();
  static const listTiles = _ListTiles._();
  static const progressIndicators = _ProgressIndicators._();
  static final filePicking = _FilePicking._();

  //$ Elevation concerned widgets
  static const bool applyElevationToAppBar = defaultElevation != 0 && true;
  static const bool applyElevationToBottomNavBar = defaultElevation != 0 && false;

  static bool get elevationAppliedToAppBar => applyElevationToAppBar;
}

//? Scaffold
class _Scaffold {
  const _Scaffold();

  final double topBodyPadding = 25;
  final double horizontalBodyPadding = 20;
  final double bottomBodyPadding = 50;
}

//? Inputs
class _Buttons {
  const _Buttons._();

  final double radius = 50;

  final elevated = const _ElevatedButtons._();
  final text = const _TextButtons._();
  final icon = const _IconButtons._();
  final floating = const _FloatingActionButtons._();
}

class _ElevatedButtons {
  const _ElevatedButtons._();
  static const _applyElevation = false;
  final double elevation = _applyElevation ? AppConstants.defaultElevation : 0;
  final double height = 60;
}

class _TextButtons {
  const _TextButtons._();

  static const _applyElevation = false;
  final double elevation = _applyElevation ? AppConstants.defaultElevation : 0;
  final double height = 60;
}

class _IconButtons {
  const _IconButtons._();

  static const _applyElevation = false;
  final double elevation = _applyElevation ? AppConstants.defaultElevation : 0;
  final double side = 60;
  final double radius = 60 / 2;
}

class _FloatingActionButtons {
  const _FloatingActionButtons._();

  static const _applyElevation = true;
  final double elevation = _applyElevation ? AppConstants.defaultElevation : 0;
  final double height = 45;
  final double iconSize = 28;
  final double radius = 10;
}

//? Inputs
class _Inputs {
  const _Inputs._();

  final AutovalidateMode inputsAutovalidationMode = AutovalidateMode.disabled;
  static const _applyElevation = false;
  final double elevation = _applyElevation ? AppConstants.defaultElevation : 0;
  final double radius = 8;
  final double height = 56;
  final double horizontalContentPadding = 24;
  final double verticalContentPadding = 15;
  final double borderWidth = 1.5;
  final int passwordInputMaxLength = 12;
  final int maxLength = 50;
  final prefixIconConstraints = const BoxConstraints(minWidth: 60, maxWidth: 60, minHeight: 56, maxHeight: 56);
  final suffixIconConstraints = const BoxConstraints(minWidth: 60, maxWidth: 60, minHeight: 56, maxHeight: 56);
}

//? Drawer
class _Drawer {
  const _Drawer._();

  final double width = 0;
  final double radius = 10;
}

//? Top Bar
class _TopBar {
  _TopBar._();

  final double radius = 0;
  final double height = 130;
  final double elevation = 3;
  final double leadingWidth = 60;
  final double buttonWidth = 60;
}

//? Bottom Bar
class _BottomBar {
  _BottomBar._();

  final double elevation = AppConstants.defaultElevation;
  final double radius = 8;
  final double height = 90;
  final double buttonSize = 80;
  final double imageHeight = 21;
}

//? Cards
class _Cards {
  const _Cards._();

  final double elevation = AppConstants.defaultElevation;
  final double radius = 8;
  final double iconSize = 36;
}

//? List Tiles
class _ListTiles {
  const _ListTiles._();

  final double radius = AppConstants.defaultRadius;
}

//? Progress Indicators
class _ProgressIndicators {
  const _ProgressIndicators._();

  final double circularStrokeWidth = 2;
  final double linearMinHeight = 4;
  final double downloadCircularColorSize = 45;
}

//? File Picking
class _FilePicking {
  _FilePicking._();

  static const int sizeLimit = 5;
  final int sizeLimitInBytes = sizeLimit * 1024 * 1024;
  final int imageQuality = 60;
  final List<String> extensions = ['jpeg', 'jpg', 'png', 'pdf'];
}
