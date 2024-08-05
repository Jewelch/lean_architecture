part of '../scaffold/smart_scaffold.dart';

enum BottomBarParents { none, recharge, history, profile }

final class _BottomBar extends StatelessWidget {
  const _BottomBar(this.bottomBarParents);

  final BottomBarParents bottomBarParents;

  @override
  Widget build(BuildContext context) => switch (bottomBarParents) {
        BottomBarParents.none => const SizedBox.shrink(),
        _ => Card(
            elevation: 10,
            color: AppColors.greyBackground,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: _homeChildren
                  .map(
                    (module) => IconButton(
                      style: IconButton.styleFrom(padding: EdgeInsets.zero),
                      onPressed: module.onPressed,
                      icon: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          module.iconOrImage.isLeft()
                              ? Icon(
                                  module.iconOrImage.left!,
                                  size: AppConstants.bottomBar.imageHeight,
                                  color: _color(module.index),
                                )
                              : Image.asset(
                                  module.iconOrImage.right!,
                                  fit: BoxFit.cover,
                                  height: AppConstants.bottomBar.imageHeight,
                                  color: _color(module.index),
                                ).customPadding(top: 1),
                          Text(
                            module.title,
                            style: AppFonts.nunito.withSize(FontSizes.subtitle).withColor(_color(module.index)),
                          ).customPadding(top: 3),
                        ],
                      ),
                    ).expanded(),
                  )
                  .toList(),
            ),
          ).overallPadding(10).resize(height: AppConstants.bottomBar.height),
      };

  Color _color(index) => switch (bottomBarParents) {
            BottomBarParents.recharge => 0,
            BottomBarParents.history => 1,
            BottomBarParents.profile => 2,
            BottomBarParents.none => -1,
          } ==
          index
      ? AppColors.secondary
      : AppColors.greyRegular;
}

final List<_PageModel> _homeChildren = [
  _PageModel(
    index: 0,
    title: 'Product',
    iconOrImage: const Left(Icons.production_quantity_limits),
    onPressed: () {},
  ),
  _PageModel(
    index: 1,
    title: 'List',
    iconOrImage: const Left(Icons.list),
    onPressed: () {},
  ),
  _PageModel(
    index: 2,
    title: 'Location',
    iconOrImage: const Left(Icons.location_pin),
    onPressed: () {},
  ),
  _PageModel(
    index: 2,
    title: 'Navigator',
    iconOrImage: const Left(Icons.navigation),
    onPressed: () {},
  ),
  _PageModel(
    index: 2,
    title: 'Profile',
    iconOrImage: const Left(Icons.person),
    onPressed: () {},
  ),
];

final class _PageModel {
  _PageModel({
    required this.index,
    required this.title,
    required this.iconOrImage,
    required this.onPressed,
  });

  final int index;
  final String title;
  final Either<IconData, String> iconOrImage;
  final VoidCallback onPressed;
}
