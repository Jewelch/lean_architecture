import 'dart:ui';

import '../../app/app_widget.dart';
import '../../base/screens/exports.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  const TopBar({
    super.key,
    required this.blurred,
    this.appBarHeight,
    required this.applyElevation,
    this.appBarBackgroundColor,
    required this.title,
    this.titleColor,
    this.titleStyle,
    this.titleWidget,
    required this.displayBack,
    required this.displayClose,
    required this.displayMenu,
    this.leadingIconData,
    this.leadingIconColor,
    this.onLeadingPressed,
    this.actionIconData,
    this.actionIconColor,
    this.actionBackgroundColor,
    this.onActionPressed,
  });

  final bool blurred;

  final double? appBarHeight;
  final bool applyElevation;
  final Color? appBarBackgroundColor;

  final String title;
  final Color? titleColor;
  final TextStyle? titleStyle;
  final Widget? titleWidget;

  final bool displayBack;
  final bool displayMenu;
  final bool displayClose;

  final IconData? leadingIconData;
  final Color? leadingIconColor;
  final void Function()? onLeadingPressed;

  final IconData? actionIconData;
  final Color? actionIconColor;

  final Color? actionBackgroundColor;
  final void Function()? onActionPressed;

  @override
  Size get preferredSize => Size.fromHeight(
        appBarHeight ?? AppConstants.topBar.height - MediaQuery.paddingOf(AppWidget.globalContext!).top,
      );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: appBarHeight,
      elevation: applyElevation ? AppConstants.topBar.elevation : 0,
      automaticallyImplyLeading: false,
      backgroundColor:
          blurred ? Colors.white.withAlpha(1) : appBarBackgroundColor ?? Theme.of(context).appBarTheme.backgroundColor,
      flexibleSpace: blurred
          ? ClipRect(
              child: BackdropFilter(
              blendMode: BlendMode.srcOver,
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Container(color: Colors.transparent),
            ))
          : null,
      leading: leadingIconData != null
          ? IconButton(
              onPressed: onLeadingPressed,
              icon: Icon(
                leadingIconData,
                color: leadingIconColor,
              ),
            )
          : displayBack
              ? IconButton(
                  onPressed: onLeadingPressed ?? Navigator.of(context).pop,
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: leadingIconColor,
                  ),
                )
              : null,
      leadingWidth: AppConstants.topBar.leadingWidth,
      title: titleWidget ?? Text(title),
      centerTitle: true,
      actions: [
        if (displayMenu)
          IconButton(
            icon: Icon(
              Icons.menu_rounded,
              color: actionIconColor,
              size: 30,
            ),
            onPressed: () {
              FocusScope.of(context).unfocus();
            },
          ).customPadding(right: 15),
        if (displayClose)
          IconButton(
            icon: Icon(
              Icons.close,
              color: actionIconColor,
              size: 30,
            ),
            onPressed: () {
              FocusScope.of(context).unfocus();
            },
          ).customPadding(right: 15),
        if (actionIconData != null)
          IconButton(
            onPressed: onActionPressed ?? () {},
            icon: Icon(
              actionIconData,
              color: actionIconColor,
            ),
          ).resize(width: AppConstants.topBar.buttonWidth)
      ],
      titleSpacing: 0,
    );
  }
}
