import 'dart:io';

import 'package:flutter/material.dart';

abstract final class AppConstants {
  //$ Default Radius
  static const double defaultRadius = 3;

  //$ Default Elevation
  static const double defaultElevation = 8;

  static const inputs = _Inputs._();
  static const buttons = _Buttons._();
  static const drawer = _Drawer._();
  static final topBar = _TopBar._();
  static final bottomBar = _BottomBar._();

  static const double logoHorizontalPadding = 64;
  static const double logoWidth = 262;
  static const double logoHeight = 80;

  static const double dropdownSymmetricHorizontalPadding = 16;

  static const double heightOfInputBox = dropDownHeight;

  //? Scaffold
  static const double bodyTopPadding = 25;
  static const double bodyMinSymetricHorizontalPadding = 20;
  static const double bodyMaxSymetricHorizontalPadding = 30;
  static const double bodyBottomPadding = 50;

  //? TabBar
  static const double tabBarHeight = 50;

  //$ Elevation concerned widgets
  static const bool applyElevationToAppBar = defaultElevation != 0 && true;
  static const bool applyElevationToBottomNavBar = defaultElevation != 0 && false;

  static bool get elevationAppliedToAppBar => applyElevationToAppBar;

  //? AppBar
  static const double appBarHeight = 90;
  static const double appBarTopPaddingToSafeArea = 12;
  static const double searchAppBarHeight = 80;
  static const double appBarSymetricHorizontalPadding = bodyMaxSymetricHorizontalPadding;
  static const double appBarButtonsBorderRadius = 8;
  static const double appBarButtonHeight = 40 + defaultElevation;
  static const double appBarButtonWidth = appBarButtonHeight + 20;
  static const double appBarButtonIconSize = 20;
  static const double appBarButtonsElevation = applyElevationToAppBar ? defaultElevation : 0;
  static const double appBarRadius = 28;
  static const double appBarElevation = applyElevationToAppBar ? defaultElevation : 0;
  static const double searchAppBatTitleSpacing = 20;

  //? AutoComplete Inputs
  static const double autoCompleteInputSuggestionsBoxElevation = defaultElevation + 2;
  static const double autoCompleteInputSuggestionsSymetricHorizontalPadding = 10;
  static const double autoCompleteInputSuggestionsSymetricVerticalPadding = 5;
  static const int autoCompleteInputDebounceDuration = 600;

  //? Cards
  static const double cardElevation = defaultElevation;
  static const double cardRadius = 8;
  static const double cardIconSize = 36;

  //? list Tiles
  static const double listTileRadius = defaultRadius;

  //? Progress Indicators
  static const double circularProgressIndicatorStrokeWidth = 2;
  static const double linearProgressIndicatorMinHeight = 4;
  static const double downloadCircularProgressIndicatorColorSize = 45;

  //? Checkbox
  static const double checkboxRadius = 20;

  //? Dropdow
  static const double dropDownHeight = 37;
  static const double minimalDropDownWidth = 48;
  static const double minimalDropDownHeight = 31;
  static const double dropDownListItemHeight = 48;

  //? Logo
  static const double logoSize = 75;

  //? Page Control
  static const double pageControlDotSize = 8;

  //? Alert Buttons
  static const double alertButtonHeight = 40;
  static const double alertButtonWidth = 140;
  static const double alertButtonRadius = defaultRadius;

  //? File Picking
  static const int pickedFileSizeLimit = 5;
  static const int pickedFileSizeLimitInBytes = pickedFileSizeLimit * 1024 * 1024;
  static const int pickedImageQuality = 60;
  static const List<String> pickableFilesExtensions = ['jpeg', 'jpg', 'png', 'pdf'];

  //? Radio Button
  static const double radioButtonRadius = defaultRadius * 2;
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
  final double elevation = 10;
}

//? Bottom Bar
class _BottomBar {
  _BottomBar._();

  final double radius = 8;
  final double height = 144 + (Platform.isIOS ? 15 : 0) + AppConstants.defaultElevation;
  final double buttonSize = 80;
  final double elevation = 5;
}
