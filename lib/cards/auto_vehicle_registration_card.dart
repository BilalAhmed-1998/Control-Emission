

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/vehicle_registration_page.dart';
import '../widgets/signin_button.dart';
import 'loading_card.dart';


class AutoVehicleRegistrationCard extends StatefulWidget {
  AutoVehicleRegistrationCard({Key key}) : super(key: key);

  @override
  State<AutoVehicleRegistrationCard> createState() => _AutoVehicleRegistrationCardState();
}

class _AutoVehicleRegistrationCardState extends State<AutoVehicleRegistrationCard> {
  TextEditingController registrationNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            topLeft: Radius.circular(10),
          ),
        ),
        width: width,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Enter registration no: ',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade800,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: TextField(
                controller: registrationNoController,
                keyboardType: TextInputType.text,
                style: TextStyle(color: Colors.black,
                    fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  prefixIcon: Icon(CupertinoIcons.car_detailed,
                    size: 22,
                    color: Colors.grey.withOpacity(0.5),),
                  hoverColor: Colors.white,
                  focusColor: Colors.white,
                  fillColor: Colors.transparent,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                    BorderSide(color: Color(0xff004040), width: 1.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                    BorderSide(color: Colors.grey.shade300, width: 1.5),
                  ),
                  hintText: 'Enter Vehicle Id (XXXxxxx)',
                  hintStyle: TextStyle(
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey.withOpacity(0.7),
                  ),),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            InkWell(
              onTap: () async{

                if( registrationNoController.text.length!=7){
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Enter valid registration no!")));
                }
                else{


                  showDialog(
                      context: context,
                      builder: (BuildContext context) => LoadingCard(
                        text: "Fetching vehicle details...",
                      ));

                  await Future.delayed(const Duration(seconds: 1));
                  if (!mounted) return;
                  Navigator.popAndPushNamed(context, VehicleRegistrationPage.routeName);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                      Text('Error occurred!, please add details manually.')));

                }



              },
              child: SignInButton(
                width: width,
                height: 56,
                text: 'Register',
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
