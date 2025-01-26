import 'package:flutter/services.dart';

import 'app/app_widget.dart';
import 'base/screens/exports.dart';

part 'main_styling.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppInjections.all();

  _Styling.apply();

  runApp(AppWidget());
}


// import 'package:window_manager/window_manager.dart';

// const WINDOWSIZE = Size(1160, 800);

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await windowManager.ensureInitialized();

//   const windowOptions = WindowOptions(
//     size: WINDOWSIZE,
//     minimumSize: WINDOWSIZE,
//     center: true,
//     backgroundColor: Colors.transparent,
//     skipTaskbar: false,
//     titleBarStyle: TitleBarStyle.hidden,
//   );
//   windowManager.waitUntilReadyToShow(windowOptions, () async {
//     await windowManager.show();
//     await windowManager.focus();
//   });