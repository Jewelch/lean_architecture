import '../../../../base/screens/exports.dart';
import '../../../../managers/location/location_manager.dart';
import '../../injections.dart';
import '../bloc/location_bloc.dart';
import '../bloc/location_events.dart';
import '../bloc/location_states.dart';

final class LocationScreen extends StatelessWidget {
  LocationScreen() {
    LocationScreenDependencies.inject();
  }

  @override
  Widget build(BuildContext context) {
    return BuildingBlocProvider<LocationBlocImpl, LocationStates>(
      create: get,
      builder: (context, state) => SmartScaffold(
        bottomBarParent: BottomBarParents.location,
        title: LocationScreenDependencies.locationManagerEnvValue,
        body: Column(
          children: [
            ElevatedButton(
              child: Text(
                "Open App Settings",
                style: AppStyles.subtitle,
              ).centerAlign(),
              onPressed: () => context.read<LocationBlocImpl>().add(OpenAppSettings()),
            ).resize(width: 200, height: 45).symmetricPadding(vertical: 20).center(),
            _Body(state).expanded(),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Observer(
              observes: get<LocationManager>().serviceEnabledObs,
              builder: (context, serviceEnabled) => Card(
                color: serviceEnabled ? AppColors.success : AppColors.error,
                child: Text(
                  "Service ${serviceEnabled ? "enabled" : "disabled"}",
                  style: AppStyles.subtitle,
                ).overallPadding(10),
              ),
            ),
            ElevatedButton(
              child: const Text("Get location"),
              onPressed: () => context.read<LocationBlocImpl>().add(GetLocation()),
            ).resize(width: 200, height: 45).customPadding(top: 50),
          ],
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body(this.state);

  final LocationStates state;

  @override
  Widget build(BuildContext context) {
    return switch (state) {
      Idle() => const SizedBox(),
      Loading() => const CircularProgressIndicator(strokeWidth: 1).squared(20).center(),
      Error(message: final message) => Text(message),
      Empty() => const SizedBox.shrink(),
      //? Pattern matching
      Success(geoCoordinates: final geoCoordinates) => SizedBox.expand(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.location_pin,
                size: 25,
                color: AppColors.secondary,
              ),
              Text(
                "Lat:   ${geoCoordinates.latitude}\nLng:  ${geoCoordinates.longitude}",
                style: AppFonts.helvetica.bold(),
              ).customPadding(top: 10),
            ],
          ).customPadding(top: 100),
        ),
    };
  }
}

// Define a custom BlocProviderWithBuilder that combines BlocProvider and BlocBuilder
class BuildingBlocProvider<B extends BlocBase<S>, S> extends StatelessWidget {
  /// Creates a new instance of [BuildingBlocProvider].
  ///
  /// [create] function creates the [Bloc] instance.
  /// [builder] function is called whenever the [Bloc] state changes.
  const BuildingBlocProvider({
    required this.create,
    required this.builder,
    super.key,
    this.lazy = true,
    this.buildWhen,
  });

  /// The function used to create the [Bloc] instance.
  final B Function(BuildContext context) create;

  /// The function used to build the widget tree based on the [Bloc] state.
  final BlocWidgetBuilder<S> builder;

  /// Whether to create the [Bloc] lazily or eagerly.
  final bool lazy;

  /// A function that decides when to rebuild the widget.
  final BlocBuilderCondition<S>? buildWhen;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<B>(
      create: create,
      lazy: lazy,
      child: BlocBuilder<B, S>(
        buildWhen: buildWhen,
        builder: builder,
      ),
    );
  }
}
