import 'package:control_emission/screens/home_page.dart';
import 'package:control_emission/widgets/custom_app_bar.dart';
import 'package:control_emission/widgets/signin_button.dart';
import 'package:flutter/material.dart';

class VehicleRegistrationPage extends StatefulWidget {
  static const routeName = '/VehicleRegistrationPage';

  const VehicleRegistrationPage({Key key}) : super(key: key);

  @override
  State<VehicleRegistrationPage> createState() =>
      _VehicleRegistrationPageState();
}

class _VehicleRegistrationPageState extends State<VehicleRegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  String dropDownValue = 'Petrol';
  TextEditingController registrationNoController = TextEditingController();
  TextEditingController makeController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController manufactureYearController = TextEditingController();
  TextEditingController co2KmController = TextEditingController();
  TextEditingController co2MController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: myAppBar('Form'),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 60, left: 20, right: 20,bottom: 20),
          width: width,
          color: Colors.white,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: width,
                  alignment: Alignment.center,
                  height: 130,
                  child: Image.asset(
                    'assets/images/only_logo.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Text(
                  'Register a Vehicle',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      height: 2,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 40,
                  child: Text(
                    'Please fill the input below',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Color(0xffA1A1A1),
                        fontSize: 15,
                        height: 1.5,
                        fontWeight: FontWeight.normal),
                  ),
                ),

                ///Vehicle registration Number///
                Text(
                  'Vehicle Registraion Number (XXXxxxx)',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: registrationNoController,
                  decoration: InputDecoration(
                    label: Text(' Enter number'),
                    labelStyle: TextStyle(
                        color: Color(0xff004040), fontStyle: FontStyle.italic),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Color(0xff8FC5A3), width: 1.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.grey.shade300, width: 1.5),
                    ),
                  ),
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Please enter Vehicle registration number.';
                    } else if (val.length >= 8 ||
                        !RegExp(r'^(?=.*[a-zA-Z])(?=.*[0-9])[A-Za-z0-9]+$')
                            .hasMatch(val)) {
                      return 'Please enter a valid registration number.';
                    } else {
                      return null;
                    }
                  },
                ),

                ///
                ///Make///
                Text(
                  'Vehicle Make',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                    height: 3,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: makeController,
                  decoration: InputDecoration(
                    label: Text(' Enter name'),
                    labelStyle: TextStyle(
                        color: Color(0xff004040), fontStyle: FontStyle.italic),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Color(0xff8FC5A3), width: 1.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.grey.shade300, width: 1.5),
                    ),
                  ),
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Please enter Vehicle name.';
                    } else {
                      return null;
                    }
                  },
                ),

                ///
                ///Company///
                Text(
                  'Vehicle Company',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                    height: 3,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: companyController,
                  decoration: InputDecoration(
                    label: Text(' Enter company'),
                    labelStyle: TextStyle(
                        color: Color(0xff004040), fontStyle: FontStyle.italic),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Color(0xff8FC5A3), width: 1.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.grey.shade300, width: 1.5),
                    ),
                  ),
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Please enter Vehicle company.';
                    } else {
                      return null;
                    }
                  },
                ),

                ///
                ///Year of Manufacture///
                Text(
                  'Manufacture Year',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                    height: 3,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: manufactureYearController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: Text(' Enter year'),
                    labelStyle: TextStyle(
                        color: Color(0xff004040), fontStyle: FontStyle.italic),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Color(0xff8FC5A3), width: 1.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.grey.shade300, width: 1.5),
                    ),
                  ),
                  validator: (val) {
                    if (val.length != 4 || !RegExp(r'^[0-9]*$').hasMatch(val)) {
                      return 'Please enter valid year.';
                    } else {
                      return null;
                    }
                  },
                ),

                ///
                ///CO2 Per KM///
                Text(
                  'CO2 per Km',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                    height: 3,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: co2KmController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: Text(' Enter value'),
                    labelStyle: TextStyle(
                        color: Color(0xff004040), fontStyle: FontStyle.italic),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Color(0xff8FC5A3), width: 1.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.grey.shade300, width: 1.5),
                    ),
                  ),
                  validator: (val) {
                    if (val.isEmpty || !RegExp(r'^[0-9]*$').hasMatch(val)) {
                      return 'Please enter valid value.';
                    } else {
                      return null;
                    }
                  },
                ),

                ///
                ///CO2 Per Mile///
                Text(
                  'CO2 per mile',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                    height: 3,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: co2MController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: Text(' Enter value'),
                    labelStyle: TextStyle(
                        color: Color(0xff004040), fontStyle: FontStyle.italic),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Color(0xff8FC5A3), width: 1.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.grey.shade300, width: 1.5),
                    ),
                  ),
                  validator: (val) {
                    if (val.isEmpty || !RegExp(r'^[0-9]*$').hasMatch(val)) {
                      return 'Please enter valid value.';
                    } else {
                      return null;
                    }
                  },
                ),

                ///
                ///Fuel Type///
                Text(
                  'Vehicle Fuel',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                    height: 3,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                DropdownButtonFormField(
                  value: dropDownValue,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  iconSize: 20,
                  items: <String>['Petrol', 'Diesel', 'Hybrid', 'Electric']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style:
                            TextStyle(color: Color(0xff004040), fontSize: 15),
                      ),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Fuel Type',
                    hintStyle: TextStyle(
                        color: Color(0xff004040), fontStyle: FontStyle.italic),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Color(0xff8FC5A3), width: 1.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.grey.shade300, width: 1.5),
                    ),
                  ),
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Please select fuel type';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (String value) {
                    setState(() {
                      dropDownValue = value;
                    });
                  },
                ),

                SizedBox(
                  height: 25,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, HomePage.routeName);

                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      Navigator.pushNamed(context, HomePage.routeName);
                    }

                  },
                  child: SignInButton(
                    width: width,
                    height: 56,
                    text: 'Submit',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
