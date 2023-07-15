import 'dart:developer';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationProvider with ChangeNotifier {
  LocationProvider() {
    getCurrentPosition();
  }
  Placemark? _currentAddress;
  Position? _currentPosition;
  double? _getDistanceInKm;

  Placemark? get currentAddress => _currentAddress;
  Position? get currentPosition => _currentPosition;
  double? get getDistanceInKm => _getDistanceInKm;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     content: Text(
      //         'Location services are disabled. Please enable the services'),
      //   ),
      // );
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(
        //     content: Text('Location permissions are denied'),
        //   ),
        // );
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     content: Text(
      //         'Location permissions are permanently denied, we cannot request permissions.'),
      //   ),
      // );
      return false;
    }
    return true;
  }

  Future<void> getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setCurrentPosition(position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setCurrentAdress(place);
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }

  setCurrentPosition(Position position) {
    _currentPosition = position;
    notifyListeners();
    return _currentPosition;
  }

  setCurrentAdress(Placemark address) {
    _currentAddress = address;
    notifyListeners();
  }

  openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    try {
      await canLaunchUrl(Uri.parse(googleUrl));
      await launchUrl(Uri.parse(googleUrl));
    } catch (e) {
      log(e.toString());
      throw "cannot launch";
    }
  }

  Future<double> getDistance(double destLat, double destLong) async {
    Position? position = _currentPosition;
    double distance = calculateDistance(
        position!.latitude, position.longitude, destLat, destLong);
    _getDistanceInKm = distance;
    return distance;
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    const p = 0.017453292519943295; // Pi/180
    const c = math.cos;
    final a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;

    return 12742 * math.asin(math.sqrt(a)); // 2 * R; R = 6371 km
  }
}
