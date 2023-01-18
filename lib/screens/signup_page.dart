import 'package:control_emission/screens/optional_registration_page.dart';
import 'package:control_emission/services/firestore_database.dart';
import 'package:control_emission/widgets/signin_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../cards/loading_card.dart';
import '../services/auth_service.dart';

class SignUpPage extends StatefulWidget {
  static const routeName = '/SignUpPage';

  const SignUpPage({Key key}) : super(key: key);


  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool obscured = true;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: width,
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: 70,
              ),
              SizedBox(
                height: 200,
                child: Image.asset(
                  'assets/images/bigIconLogo.png',
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              ///name field///
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: TextField(
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
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
                      hintText: 'Enter Name',
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey.withOpacity(0.7),
                      )),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              ///email field///
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
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
                      hintText: 'Enter Email Address',
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey.withOpacity(0.7),
                      )),
                ),
              ),
              SizedBox(
                height: 16,
              ),

              ///password field///
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: TextField(
                  controller: passwordController,
                  obscureText: obscured,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscured
                              ? Icons.visibility_off_outlined
                              : Icons.visibility,
                          color: Colors.grey.shade700,
                        ),
                        onPressed: () {
                          setState(() {
                            obscured = !obscured;
                          });
                        },
                      ),
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
                      hintText: 'Enter Password',
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey.withOpacity(0.7),
                      )),
                ),
              ),
              ///password Confirmation field///
              SizedBox(
                height: 16,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: TextField(
                  controller: confirmPasswordController,
                  obscureText: obscured,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscured
                              ? Icons.visibility_off_outlined
                              : Icons.visibility,
                          color: Colors.grey.shade700,
                        ),
                        onPressed: () {
                          setState(() {
                            obscured = !obscured;
                          });
                        },
                      ),
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
                      hintText: 'Confirm Password',
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey.withOpacity(0.7),
                      )),
                ),
              ),
              ///
              SizedBox(
                height: 50,
              ),
              InkWell(
                enableFeedback: true,
                onTap: () async {

                  signingUpProtocol();

                },
                child: SignInButton(
                  width: width,
                  height: 56,
                  text: 'Sign Up',
                )
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff004040),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signingUpProtocol () async{
    bool emailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailController.text);
    bool passValid =
    RegExp("^.{8,}\$").hasMatch(passwordController.text);

    if (emailValid && passValid && nameController.text.isNotEmpty && FirebaseAuth.instance.currentUser == null) {
      AuthService().customSnackBarMessenger(context, 'Signing Up...');
      await AuthService().signUpWithEmailPassword(
          context, emailController.text, passwordController.text,nameController.text);

      if(FirebaseAuth.instance.currentUser!=null){

        showDialog(
            context: context,
            builder: (BuildContext context) => LoadingCard(
              text: "Creating New User",
            ));
        if (!mounted) return;
        await FireStoreDatabase.createNewUser(context);
        if (!mounted) return;
        Navigator.popAndPushNamed(context, OptionalRegistrationPage.routeName);
      }
    }else if (passwordController.text != confirmPasswordController.text){

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Your password is not matching!')));
    }
    else if ( nameController.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please enter your name!')));

    }
    else {
      (!emailValid)
          ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please enter a valid email.'),
      ))
          : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please enter min 8 digit password!'),
      ));
    }

  }
}
