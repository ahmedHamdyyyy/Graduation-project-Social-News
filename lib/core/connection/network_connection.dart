import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkConnection {
  static Future<bool> get isConnected async {
    
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }

  static bool checkConnection(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }

  static Stream<ConnectivityResult> get connectionStream =>
      Connectivity().onConnectivityChanged;
}
