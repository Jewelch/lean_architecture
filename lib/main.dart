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
