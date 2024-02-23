part of 'main.dart';

class _Styling {
  static void statusBarTransparency() => SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
      ));

  static void allowedDeviceOrientations() => SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
}
