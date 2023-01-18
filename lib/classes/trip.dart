class Trip {
  String startingAddress, endingAddress,duration;
  double distance;
  DateTime startingTime, endingTime;

  Trip(
      {this.distance,
      this.duration,
      this.endingAddress,
      this.startingAddress,
      this.endingTime,
      this.startingTime});
}
