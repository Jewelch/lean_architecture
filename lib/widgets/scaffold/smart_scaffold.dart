import 'package:lean_requester/lean_interceptor.dart';

import '../../base/screens/exports.dart';
import '../top_bar/top_bar.dart';

part '../bottom_bar/bottom_bar.dart';

class SmartScaffold extends StatelessWidget {
  const SmartScaffold({
    super.key,
    this.blurredAppBar = false,
    this.applyElevationToAppBar = true,
    this.appbarBackgroundColor,
    required this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation = FloatingActionButtonLocation.centerDocked,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.displayBack = false,
    this.displayMenu = false,
    this.displayClose = false,
    this.appBarHeight,
    this.title,
    this.tilteColor = Colors.white,
    this.titleStyle,
    this.titleWidget,
    this.leadingIconData,
    this.leadingIconColor = AppColors.greyDark,
    this.onLeadingPressed,
    this.actionIconData,
    this.actionIconColor = AppColors.primary,
    this.actionBackgroundColor,
    this.onActionPressed,
    this.displayAppBar = true,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.formKey,
    this.isScrollable = false,
    required this.bottomBarParent,
  });

  final bool blurredAppBar;

  final bool isScrollable;

  final double? appBarHeight;
  final Color? appbarBackgroundColor;
  final bool applyElevationToAppBar;
  final Widget body;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;
  final bool? resizeToAvoidBottomInset;

  final bool displayBack;
  final bool displayMenu;
  final bool displayClose;

  final String? title;
  final Color? tilteColor;
  final TextStyle? titleStyle;
  final Widget? titleWidget;

  final IconData? actionIconData;
  final void Function()? onLeadingPressed;
  final bool displayAppBar;
  final IconData? leadingIconData;
  final Color? leadingIconColor;
  final Color? actionBackgroundColor;
  final Color? actionIconColor;
  final void Function()? onActionPressed;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final GlobalKey? formKey;
  final BottomBarParents bottomBarParent;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Scaffold(
          extendBody: extendBody,
          extendBodyBehindAppBar: extendBodyBehindAppBar,
          key: key,
          appBar: displayAppBar
              ? TopBar(
                  blurred: blurredAppBar,
                  appBarHeight: appBarHeight,
                  applyElevation: applyElevationToAppBar,
                  appBarBackgroundColor: appbarBackgroundColor,
                  displayBack: displayBack,
                  displayMenu: displayMenu,
                  displayClose: displayClose,
                  title: title ?? "",
                  titleColor: tilteColor,
                  titleStyle: titleStyle,
                  titleWidget: titleWidget,
                  leadingIconData: leadingIconData,
                  leadingIconColor: leadingIconColor,
                  onLeadingPressed: onLeadingPressed,
                  actionIconData: actionIconData,
                  actionIconColor: actionIconColor,
                  actionBackgroundColor: actionBackgroundColor,
                  onActionPressed: onActionPressed,
                )
              : null,
          body: isScrollable ? SingleChildScrollView(child: body) : body,
          floatingActionButton: floatingActionButton,
          floatingActionButtonLocation: floatingActionButtonLocation ??
              (Platform.isIOS
                  ? FloatingActionButtonLocation.endDocked
                  : FloatingActionButtonLocation.endFloat),
          backgroundColor: backgroundColor,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          bottomNavigationBar: bottomNavigationBar ?? _BottomBar(bottomBarParent).visibleWhen(true),
        ),
      );
}
