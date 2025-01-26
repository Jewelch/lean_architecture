import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../base/screens/exports.dart';
import '../modules/index.dart';
import '../modules/product_details_enum/presentation/screen/product_screen.dart';

class AppWidget extends StatelessWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();
  static BuildContext? get globalContext => navigatorKey.currentContext;

  AppWidget({super.key}) {
    get<ConnectivityMonitor>().startMonitoring();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppSettings>(
      create: get,
      child: BlocBuilder<AppSettings, SettingsState>(
        builder: (_, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,

            //$ Theme Management
            themeMode: state.themeMode,
            theme: AppThemes.light,
            darkTheme: AppThemes.dark,

            //! Localizations
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppSettings.supportedLocales,
            locale: state.locale,

            home: Scaffold(
              body: Column(
                children: [
                  Expanded(
                    child: [
                      ProductDetailsScreen(),
                      ProductDetailsScreenEnum(),
                      ProductsScreen(),
                      LocationScreen(),
                      const ProfileScreen(),
                    ][1],
                  ),
                  const _ConnectivityWidget(),
                ],
              ),
            ),
          )
              .materialAppBanner(
                color: AppColors.error,
                message: AppInjections.dependencyContainerEnvValue,
                location: BannerLocation.topStart,
              )
              .materialAppBanner(
                color: AppColors.warning,
                message: AppInjections.cacheManagerEnvValue,
                location: BannerLocation.topEnd,
              );
        },
      ),
    );
  }
}

class _ConnectivityWidget extends StatelessWidget {
  const _ConnectivityWidget();

  @override
  Widget build(BuildContext context) {
    final connectivityMonitor = get<ConnectivityMonitor>();

    return Observer(
        observes: connectivityMonitor.isConnectedObs,
        builder: (context, isConnected) => Container(
              height: 35,
              width: double.infinity,
              color: isConnected ? AppColors.success : AppColors.error,
              child: AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText(
                    connectivityMonitor.runtimeType.toString(),
                    textAlign: TextAlign.center,
                    textStyle: AppStyles.caption.bold(),
                  ),
                ],
                repeatForever: true,
                pause: const Duration(seconds: 5),
              ).align(Alignment.bottomCenter).customPadding(bottom: 14),
            ));
  }
}
