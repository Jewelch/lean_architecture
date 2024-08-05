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
      create: (_) => ThemeCubit(),
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
                      LocationScreen(),
                      ProductsScreen(),
                      ProductDetailsScreen(),
                    ][1],
                  ),
                  const _ConnectivityWidget(),
                ],
              ),
            ),
          )
              .materialAppBanner(
                color: AppColors.error,
                message: AppDependencies.dependencyContainerEnvValue,
                location: BannerLocation.topStart,
              )
              .materialAppBanner(
                color: AppColors.warning,
                message: AppDependencies.cacheManagerEnvValue,
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
  @override
  Widget build(BuildContext context) {
    return Observer(
      observes: get<ConnectivityMonitor>().isConnectedObs,
      builder: (context, isConnected) => Container(
          height: 20,
          width: double.infinity,
          color: isConnected ? AppColors.success : AppColors.error,
          child: Column(
            children: [
              Text(
                get<ConnectivityMonitor>().runtimeType.toString(),
                style: AppStyles.caption.bold().withColor(AppColors.primary),
              ).align(Alignment.centerLeft).customPadding(left: 35, top: 3),
            ],
          )),
    );
  }
}
