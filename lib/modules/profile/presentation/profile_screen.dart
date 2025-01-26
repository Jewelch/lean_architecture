import 'package:lean_architecture/base/extensions/index.dart';

import '../../../base/screens/exports.dart';

part 'widgets/app_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SmartScaffold(
      title: context.localizations?.profileScreen,
      leadingIconData: Icons.language,
      onLeadingPressed: context.settings.toggleLocale,
      actionIconData: context.settings.themeIcon,
      onActionPressed: context.settings.toggleThemeMode,
      body: const SizedBox.expand(
        child: Column(
          children: [
            Text("numeric.safe()"),
          ],
        ),
      ),
      bottomBarParent: BottomBarParents.profile,
    );
  }
}
