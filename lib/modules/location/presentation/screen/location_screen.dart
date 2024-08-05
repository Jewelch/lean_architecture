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
    return BlocProvider<LocationBlocImpl>(
        create: (_) => get<LocationBlocImpl>(),
        child: BlocConsumer<LocationBlocImpl, LocationStates>(
          listener: (context, state) {},
          builder: (context, state) => SmartScaffold(
            bottomBarParent: BottomBarParents.recharge,
            title: LocationScreenDependencies.locationManagerEnvValue,
            body: Column(
              children: [
                ElevatedButton(
                  child: Text(
                    "Open Location Settings",
                    style: AppStyles.subtitle.withColor(AppColors.scaffold),
                  ).centerAlign(),
                  onPressed: () => context.read<LocationBlocImpl>().add(OpenAppSettings()),
                ).resize(width: 200, height: 45).symmetricPadding(vertical: 20).center(),
                _body(context, state).expanded(),
              ],
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Observer(
                  observes: get<LocationManager>().serviceEnabledObs,
                  builder: (context, serviceEnabled) => Container(
                    padding: const EdgeInsets.all(4),
                    color: serviceEnabled ? AppColors.success : AppColors.error,
                    child: Text("Service ${serviceEnabled ? "enabled" : "disabled"}"),
                  ),
                ),
                ElevatedButton(
                  child: const Text("Get location"),
                  onPressed: () => context.read<LocationBlocImpl>().add(GetLocation()),
                ).resize(width: 200, height: 45).customPadding(top: 10),
              ],
            ),
          ),
        ));
  }

  Widget _body(BuildContext context, LocationStates state) {
    return switch (state) {
      Idle() => const SizedBox(),
      Loading() => const CircularProgressIndicator(strokeWidth: 1).squared(side: 20).center(),
      Error() => Text(state.message),
      Empty() => const SizedBox.shrink(),
      //? Pattern matching
      Success(geoCoordinates: final geoCoordinates) => SizedBox.expand(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
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
          ),
        ),
    };
  }
}
