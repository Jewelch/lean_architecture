import '../../base/screens/exports.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SmartScaffold(
      title: "Profile",
      bottomBarParent: BottomBarParents.profile,
      body: SizedBox.expand(
        child: Column(
          children: [
            Text("numeric.safe()"),
          ],
        ),
      ),
    );
  }
}
