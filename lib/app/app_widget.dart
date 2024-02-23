import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lean_requester/lean_interceptor.dart';

import '../main.dart';
import '../modules/products/presentation/screen/product_screen.dart';
import 'themes/app_themes.dart';

class AppWidget extends StatelessWidget {
  AppWidget({super.key}) {
    sl<ConnectivityMonitor>().startMonitoring();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (_, theme) {
          return MaterialApp(
            theme: theme,
            home: const ProductsScreen(),
          );
        },
      ),
    );
  }
}
