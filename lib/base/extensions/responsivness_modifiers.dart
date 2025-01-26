import '../screens/exports.dart';

extension ResponiveVisibilityExt on Widget {
  Visibility webOnly(
    BuildContext context, {
    Key? key,
    Widget replacement = const SizedBox.shrink(),
  }) =>
      Visibility(
        key: key,
        replacement: replacement,
        visible: MediaQuery.sizeOf(context).width >= 830,
        child: this,
      );

  Visibility mobileOnly(
    BuildContext context, {
    Key? key,
    Widget replacement = const SizedBox.shrink(),
  }) =>
      Visibility(
        key: key,
        replacement: replacement,
        visible: MediaQuery.sizeOf(context).width < 830,
        child: this,
      );
}
