import '../resources/app_resources.dart';

abstract final class AppImages {
  static const imagesFolder = AppResources.imagesFolder;

  static const appLogo = "$imagesFolder/app_logo.png";
  static const simpleLogo = "$imagesFolder/simple_logo.png";
  static const onboardingImage = "$imagesFolder/onboarding_image.png";
  static const cancelIcon = "$imagesFolder/cancel_icon.png";
  static const bottomBar = _BottomBar();
  static const personWalking = "$imagesFolder/person_walking.png";
}

interface class _BottomBar {
  const _BottomBar();

  final phone = "${AppImages.imagesFolder}/phone.png";
  final messageBubble = "${AppImages.imagesFolder}/message_bubble.png";
  final danger = "${AppImages.imagesFolder}/danger.png";
}
