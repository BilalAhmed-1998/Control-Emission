



import 'classes/Vehicle.dart';
import 'classes/trip.dart';

List <Vehicle> vehicles = [
  Vehicle(
    co2Km: 98,
    co2M: 158,
    yearOfManufacture: 2015,
    fuelType: 'Hybrid',
    make: 'Honda',
    company: 'Vezel',
    registrationNo: 'ABF-300',
    totalTrips: 4
  ),
  Vehicle(
    co2Km: 56,
    co2M: 128,
    yearOfManufacture: 2017,
    fuelType: 'Petrol',
    make: 'Toyota',
    company: 'Corolla',
    registrationNo: 'LEC-144',
    totalTrips: 1
  ),
  Vehicle(
    co2Km: 120,
    co2M: 140,
    yearOfManufacture: 2022,
    fuelType: 'Diesel',
    make: 'Nissan',
    company: 'Juke',
    registrationNo: 'RWL-144',
    totalTrips: 3
  ),
];

List <Trip> trips = [
  Trip(
    startingAddress: 'Islamabad',
    endingAddress: 'Taxila',
    startingTime: DateTime.now(),
    endingTime: DateTime.now(),
    distance: 110,
    duration: '1h 32m',
  ),
  Trip(
    startingAddress: 'G13-3',
    endingAddress: 'F7-2',
    startingTime: DateTime.now(),
    endingTime: DateTime.now(),
    distance: 70,
    duration: '1h 10m',
  ),
  Trip(
    startingAddress: 'Home',
    endingAddress: 'Jinnah Park',
    startingTime: DateTime.now(),
    endingTime: DateTime.now(),
    distance: 70,
    duration: '1h 10m',
  ),
];