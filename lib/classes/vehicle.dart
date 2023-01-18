class Vehicle {
  double co2Km, co2M;
  String fuelType, make, company, registrationNo, docId;
  int yearOfManufacture, totalTrips;

  Vehicle(
      {this.fuelType,
      this.co2Km,
      this.co2M,
      this.company,
      this.make,
      this.yearOfManufacture,
      this.registrationNo,
      this.docId = '',
      this.totalTrips = 0});
}
