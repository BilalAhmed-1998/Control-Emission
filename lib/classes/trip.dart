import 'package:google_maps_flutter/google_maps_flutter.dart';

class Trip {
  LatLng startingCoordinates, endingCoordinates;
  String startingAddress, endingAddress, duration, encodedPoints;
  double distance;
  DateTime startingTime, endingTime;

  Trip(
      {this.distance,
      this.duration,
      this.endingAddress,
      this.startingAddress,
      this.endingTime,
      this.startingTime,
      this.encodedPoints,
      this.endingCoordinates,
      this.startingCoordinates});
}
