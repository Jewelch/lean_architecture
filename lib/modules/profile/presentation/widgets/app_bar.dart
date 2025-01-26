part of '../profile_screen.dart';

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    final settingsController = context.read<AppSettings>();

    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.language),
        onPressed: settingsController.toggleLocale,
      ),
      title: const Text("Tic Tac Toe"),
      actions: [
        BlocBuilder<AppSettings, SettingsState>(
          builder: (_, state) => IconButton(
            icon: Icon(settingsController.themeIcon),
            onPressed: settingsController.toggleThemeMode,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppConstants.topBar.height);
}
