abstract final class AppImages {
  static const imagesFolder = "assets/images";

  static const appLogo = "$imagesFolder/cg_logo.jpeg";
  static const bottomBar = _BottomBar();
}

interface class _BottomBar {
  const _BottomBar();

  final recharge = "${AppImages.imagesFolder}/recharge.png";
  final history = "${AppImages.imagesFolder}/history.png";
  final profile = "${AppImages.imagesFolder}/profile.png";
}
