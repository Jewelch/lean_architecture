import '../../../base/screens/exports.dart';
import '../../../managers/location/location_manager.dart';
import '../injections.dart';
import 'bloc/location_bloc.dart';
import 'bloc/location_events.dart';
import 'bloc/location_states.dart';

final class LocationScreen extends BlocProviderWidget<LocationBloc> {
  LocationScreen() : super(dependencies: LocationScreenDependencies());

  @override
  Widget build(BuildContext context) => SmartScaffold(
        bottomBarParent: BottomBarParents.location,
        title: LocationScreenDependencies.locationManagerEnvValue,
        body: BlocBuilder<LocationBloc, LocationStates>(
          builder: (context, state) => Column(
            children: [
              ElevatedButton(
                child: Text(
                  "Open App Settings",
                  style: AppStyles.subtitle,
                ).centerAlign(),
                onPressed: () => BlocProvider.of<LocationBloc>(context).add(OpenAppSettings()),
              ).resize(width: 200, height: 45).symmetricPadding(vertical: 20).center(),
              _Body(state),
            ],
          ),
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
              onPressed: () => BlocProvider.of<LocationBloc>(context).add(GetLocation()),
            ).resize(width: 200, height: 45).customPadding(top: 50),
          ],
        ),
      );
}

class _Body extends StatelessWidget {
  const _Body(this.state);

  final LocationStates state;

  @override
  Widget build(BuildContext context) => switch (state) {
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
                  style: AppFonts.helvetica.bold().copyWith(color: AppColors.secondary),
                ).customPadding(top: 10),
              ],
            ).customPadding(top: 100),
          ),
      }
          .expanded();
}
