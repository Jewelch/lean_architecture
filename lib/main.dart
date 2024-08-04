import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:lean_requester/lean_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app_widget.dart';
import 'base/screens/exports.dart';

part 'main_injection.dart';
part 'main_styling.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _Dependencies.all();

  _Styling.apply();

  runApp(AppWidget());
}
