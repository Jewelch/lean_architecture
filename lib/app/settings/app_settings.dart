import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsState {
  final ThemeMode themeMode;
  final Locale locale;

  const SettingsState({
    required this.themeMode,
    required this.locale,
  });

  SettingsState copyWith({ThemeMode? themeMode, Locale? locale}) => SettingsState(
        themeMode: themeMode ?? this.themeMode,
        locale: locale ?? this.locale,
      );
}

class AppSettings extends Cubit<SettingsState> {
  AppSettings()
      : super(
          SettingsState(
            themeMode: ThemeMode.light,
            locale: supportedLocales.first,
          ),
        );

  static const supportedLocales = <Locale>[
    Locale('fr'),
    Locale('en'),
  ];

  void toggleThemeMode() => emit(
        state.copyWith(themeMode: state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light),
      );

  void setLocale(Locale locale) => emit(state.copyWith(locale: locale));

  void toggleLocale() => setLocale(
        state.locale == supportedLocales.first ? supportedLocales.last : supportedLocales.first,
      );

  IconData get themeIcon => state.themeMode == ThemeMode.light ? Icons.dark_mode : Icons.light_mode;
}
