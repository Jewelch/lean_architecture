// // Flutter imports:
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/widgets.dart';
// // Package imports:
// import 'package:flutter_sheet_localization/flutter_sheet_localization.dart';

// part 'localizations.g.dart';

// /// YOU SHOULD DEFINETLY SAVE YOUR EXTERNAL SHEET BEFORE DOING THIS

// /// Set execute permission on your script only once =>
// //      chmod +x generateLocalizations.sh

// /// To run your script =>
// //    sh generateLocalizations.sh

// // https://docs.google.com/spreadsheets/d/1CXicqcOux8Fsi6DE2eifCKTH2nX857tv-UW0D2OXZ4g/edit#gid=0
// const String docId = "1CXicqcOux8Fsi6DE2eifCKTH2nX857tv-UW0D2OXZ4g";
// const String sheetId = "0";

// @SheetLocalization(docId, sheetId, 1)
// class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizationsData> {
//   const AppLocalizationsDelegate();

//   @override
//   bool isSupported(Locale locale) => localizedLabels.containsKey(locale);

//   @override
//   Future<AppLocalizationsData> load(Locale locale) => SynchronousFuture<AppLocalizationsData>(localizedLabels[locale]!);
//   @override
//   bool shouldReload(AppLocalizationsDelegate old) => false;
// }
