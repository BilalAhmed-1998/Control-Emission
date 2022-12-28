import 'package:control_emission/classes/Vehicle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  Vehicle vehicle;
  CustomAlertDialog({Key key, this.vehicle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        vehicle.registrationNo,
        style: TextStyle(
          color: Colors.grey.shade800,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(
                CupertinoIcons.circle_fill,
                color: Colors.green,
                size: 14,
              ),
              Text(
                '  Company : ${vehicle.company}',
                style: TextStyle(
                    color: Colors.grey.shade800, fontSize: 14, height: 2),
              )
            ],
          ),
          Row(
            children: [
              Icon(
                CupertinoIcons.circle_fill,
                color: Colors.black,
                size: 14,
              ),
              Text(
                '  Make : ${vehicle.make}',
                style: TextStyle(
                    color: Colors.grey.shade800, fontSize: 14, height: 2),
              )
            ],
          ),
          Row(
            children: [
              Icon(
                CupertinoIcons.circle_fill,
                color: Colors.redAccent,
                size: 14,
              ),
              Text(
                '  Year of Manufacture : ${vehicle.yearOfManufacture}',
                style: TextStyle(
                    color: Colors.grey.shade800, fontSize: 14, height: 2),
              )
            ],
          ),
          Row(
            children: [
              Icon(
                CupertinoIcons.circle_fill,
                color: Colors.amber,
                size: 14,
              ),
              Text(
                '  Fuel Type : ${vehicle.fuelType}',
                style: TextStyle(
                    color: Colors.grey.shade800, fontSize: 14, height: 2),
              )
            ],
          ),
          Row(
            children: [
              Icon(
                CupertinoIcons.circle_fill,
                color: Colors.deepOrange,
                size: 14,
              ),
              Text(
                '  CO2 Emission per Mile : ${vehicle.co2M}',
                style: TextStyle(
                    color: Colors.grey.shade800, fontSize: 14, height: 2),
              )
            ],
          ),
          Row(
            children: [
              Icon(
                CupertinoIcons.circle_fill,
                color: Colors.blue,
                size: 14,
              ),
              Text(
                '  CO2 Emission per KM : ${vehicle.co2Km}',
                style: TextStyle(
                    color: Colors.grey.shade800, fontSize: 14, height: 2),
              )
            ],
          ),
        ],
      ),
    );
  }
}
