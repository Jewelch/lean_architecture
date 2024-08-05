abstract class AppImages {
  static const imagesFolder = "assets/images";

  static const logo = "$imagesFolder/ic_logo.png";
  static const icOutlet = "$imagesFolder/ic_outlet.svg";
  static const icStatus = "$imagesFolder/ic_status.svg";
  static const icPower = "$imagesFolder/ic_power.svg";
  static const cancelIcon = "$imagesFolder/cancel_icon.png";
  static const personWalking = "$imagesFolder/person_walking.png";
  static const flash = "$imagesFolder/flash.png";
  static const flashBig = "$imagesFolder/flash_big.png";
  static const radioButtonOn = "$imagesFolder/ic_radio_button_on.svg";
  static const radioButtonOff = "$imagesFolder/ic_radio_button_off.svg";
  static const clock = "$imagesFolder/clock.png";
  static const shutdown = "$imagesFolder/shutdown.png";
  static const wallet = "$imagesFolder/wallet.png";
  static const noDataShadow = "$imagesFolder/no_data_shadow.png";
  static const car = "$imagesFolder/car.png";
  static const car2 = "$imagesFolder/car2.svg";
  static const logout = "$imagesFolder/logout.png";
  static const miles = "$imagesFolder/ic_miles.svg";
  static const mileage = "$imagesFolder/mileage.png";

  static const bottomBar = _BottomBar();
}

class _BottomBar {
  const _BottomBar();

  final recharge = "${AppImages.imagesFolder}/recharge.png";
  final history = "${AppImages.imagesFolder}/history.png";
  final profile = "${AppImages.imagesFolder}/profile.png";
}
