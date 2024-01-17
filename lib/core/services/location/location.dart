// ignore_for_file: use_build_context_synchronously

import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';

class LocationServices {
  Future<bool> checkLocationActivation(BuildContext context) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever ||
          permission == LocationPermission.denied) {
        permissionDenied(context);
        return false;
      }
    } else if (permission == LocationPermission.deniedForever) {
      permissionDenied(context);
      return false;
    }
    if (await Geolocator.isLocationServiceEnabled()) {
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'location service is unable, enable it to continue',
          ),
          action: SnackBarAction(
            label: 'open setting',
            onPressed: () async => await Geolocator.getCurrentPosition(),
          ),
        ),
      );
      return false;
    }
  }

  Future<Position> get getCurrentPosition async =>
      await Geolocator.getCurrentPosition();

  void permissionDenied(BuildContext context) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'location permission denied from this app, activate to continue',
          ),
          action: SnackBarAction(
            label: 'open setting',
            onPressed: () async => await Geolocator.openAppSettings(),
          ),
        ),
      );
}
