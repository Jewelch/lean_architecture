import 'dart:io';

import 'package:path_provider/path_provider.dart';

abstract final class AppResources {
  static const String fontsFolder = 'assets/fonts';
  static const String mocksFolder = 'assets/mock';
  static const String imagesFolder = 'assets/images';
  static const String jsonFolder = 'assets/json';

  static Future<String> storageFolderPerPlatfrom() async =>
      Platform.isIOS ? (await getApplicationDocumentsDirectory()).path : '/storage/emulated/0/Download';
}
