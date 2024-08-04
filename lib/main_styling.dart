part of 'main.dart';

class _Styling {
  static void _statusBarTransparency() => SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
        ),
      );

  static void _allowedDeviceOrientations() => SystemChrome.setPreferredOrientations(
        [
          ...DeviceOrientation.values,
        ],
      );

  static void apply() => {
        _statusBarTransparency(),
        _allowedDeviceOrientations(),
      };
}
