
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../classes/trip.dart';



class FireStoreDatabase{

  static final CollectionReference userCollection =
  FirebaseFirestore.instance.collection('users');

  ///User Collection Operations///

  static Future createNewUser(context) async {
    try {
      await userCollection
          .doc(FirebaseAuth.instance.currentUser.uid)
          .set({
        'totalVehicles': 0,
        'totalTrips': 0,
      });
      return true;
    } on Exception catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      return false;
    }
  }

  static Future updateTotalTrips(context) async {
    try {
      await userCollection
          .doc(FirebaseAuth.instance.currentUser.uid)
          .update({
        'totalTrips' : FieldValue.increment(1)
      });
      return true;
    } on Exception catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      return false;
    }
  }

  static Future updateTotalVehicles(context) async {
    try {
      await userCollection
          .doc(FirebaseAuth.instance.currentUser.uid)
          .update({
        'totalVehicles' : FieldValue.increment(1)
      });
      return true;
    } on Exception catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      return false;
    }
  }

  /// users/Vehicles  Collection////

  static Future registerNewVehicle(vehicle, context) async {
    try {
      await userCollection
          .doc(FirebaseAuth.instance.currentUser.uid)
      .collection('vehicles')
      .doc(Timestamp.now().toString())
          .set({
        'vehicleRegistrationNo': vehicle.registrationNo,
        'company': vehicle.company,
        'fuelType': vehicle.fuelType,
        'make': vehicle.make,
        'yearOfManufacture': vehicle.yearOfManufacture,
        'co2M': vehicle.co2M,
        'co2Km': vehicle.co2Km,
        'vehicleTotalTrips': vehicle.totalTrips,
      });
      return true;
    } on Exception catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      return false;
    }
  }

  static Future updateVehicleTrips(String vehicleDocId,context) async {
    try {
      await userCollection
          .doc(FirebaseAuth.instance.currentUser.uid)
      .collection('vehicles')
      .doc(vehicleDocId)
          .update({
        'vehicleTotalTrips' : FieldValue.increment(1)
      });
      return true;
    } on Exception catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      return false;
    }
  }

  ///users/vehicles/trips///

  static Future setNewTrip(String vehicleDocId,Trip trip, context) async {

    try {
      await userCollection
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection('vehicles')
          .doc(vehicleDocId)
          .collection('trips')
          .doc(Timestamp.now().toString())
          .set({
        'encodedPoints' : trip.encodedPoints,
        'startingTime' : trip.startingTime,
        'endingTime' : trip.endingTime,
        'distance' : trip.distance,
        'duration': trip.duration,
        'startingAddress': trip.startingAddress,
        'endingAddress': trip.endingAddress,
        'startingCoordinates': GeoPoint(trip.startingCoordinates.latitude,trip.startingCoordinates.longitude),
        'endingCoordinates': GeoPoint(trip.endingCoordinates.latitude,trip.endingCoordinates.longitude),

      });
      return true;
    } on Exception catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      return false;
    }



  }





}