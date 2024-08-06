import 'package:animated_text_kit/animated_text_kit.dart';

import '../base/screens/exports.dart';
import '../modules/index.dart';

class AppWidget extends StatelessWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();
  static BuildContext? get globalContext => navigatorKey.currentContext;

  AppWidget({super.key}) {
    get<ConnectivityMonitor>().startMonitoring();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => get<ThemeCubit>(),
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (_, theme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            theme: theme,
            home: Scaffold(
              body: Column(
                children: [
                  Expanded(
                    child: [
                      ProductDetailsScreen(),
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
    return Observer(
        observes: get<ConnectivityMonitor>().isConnectedObs,
        builder: (context, isConnected) => Container(
              height: 35,
              width: double.infinity,
              color: isConnected ? AppColors.success : AppColors.error,
              child: AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText(
                    get<ConnectivityMonitor>().runtimeType.toString(),
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
