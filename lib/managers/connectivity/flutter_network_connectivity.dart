import 'package:cg_core_defs/cg_core_defs.dart';
import 'package:flutter_network_connectivity/flutter_network_connectivity.dart';

class FlutterNetConnectivity extends ConnectivityMonitor {
  final FlutterNetworkConnectivity _connectivity;

  FlutterNetConnectivity(this._connectivity);

  @override
  void startMonitoring() {
    super.startMonitoring();
    _connectivity.getInternetAvailabilityStream().listen((isConnected) {
      isConnectedObs.value = isConnected;
    });
  }
}
