import 'dart:math';

import 'package:maps_toolkit/maps_toolkit.dart' as map_tool;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class GeoService {
  List<LatLng> decodeCoordinates(String encodedString) {
    List<map_tool.LatLng> decodedMapToolPoints =
        map_tool.PolygonUtil.decode(encodedString);

    List<LatLng> coordinatesList = [];

    for (var i = 0; i < decodedMapToolPoints.length; i++) {
      coordinatesList.add(LatLng(
          decodedMapToolPoints[i].latitude, decodedMapToolPoints[i].longitude));
    }

    return coordinatesList;
  }

  String encodeCoordinates(List<LatLng> pointsList) {
    List<map_tool.LatLng> mapToolPoints = [];

    for (var i = 0; i < pointsList.length; i++) {
      mapToolPoints.add(
          map_tool.LatLng(pointsList[i].latitude, pointsList[i].longitude));
    }

    String encodedString = map_tool.PolygonUtil.encode(mapToolPoints);
    return encodedString;
  }

  double calculateTotalDistance(List<LatLng> polylineCoordinates) {
    double totalDistance = 0;
    for (var i = 0; i < polylineCoordinates.length - 1; i++) {
      totalDistance += calculateDistance(
          polylineCoordinates[i].latitude,
          polylineCoordinates[i].longitude,
          polylineCoordinates[i + 1].latitude,
          polylineCoordinates[i + 1].longitude);
    }
    return totalDistance;
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  Future<String> addressFromCoordinates(LatLng coordinate) async {
    List<Placemark> placeMarks = await placemarkFromCoordinates(
        coordinate.latitude, coordinate.longitude);

    String address =
        '${placeMarks[0].name.split(' ').first}, ${placeMarks[0].locality}';

    return address;
  }

  LatLngBounds getRespectedLatLngBounds(
      LatLng pickupLatLng, LatLng dropOffLatLng) {
    LatLngBounds latLngBounds;
    if (pickupLatLng.latitude > dropOffLatLng.latitude &&
        pickupLatLng.longitude > dropOffLatLng.longitude) {
      latLngBounds =
          LatLngBounds(southwest: dropOffLatLng, northeast: pickupLatLng);
    } else if (pickupLatLng.longitude > dropOffLatLng.longitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(pickupLatLng.latitude, dropOffLatLng.longitude),
          northeast: LatLng(dropOffLatLng.latitude, pickupLatLng.longitude));
    } else if (pickupLatLng.latitude > dropOffLatLng.latitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(dropOffLatLng.latitude, pickupLatLng.longitude),
          northeast: LatLng(pickupLatLng.latitude, dropOffLatLng.longitude));
    } else {
      latLngBounds =
          LatLngBounds(southwest: pickupLatLng, northeast: dropOffLatLng);
    }

    return latLngBounds;
  }
}
