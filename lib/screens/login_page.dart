import 'package:control_emission/screens/signup_page.dart';
import 'package:control_emission/widgets/signin_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';


import '../services/auth_service.dart';
import 'home_page.dart';


class LoginPage extends StatefulWidget {
  static const routeName = '/LoginPage';

  const LoginPage({Key key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscured = true;
  String emailText = "";
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: width,
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 40),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 50),
                width: width,
                height: 300,
                child: SvgPicture.asset(
                  'assets/images/login_aesthetics.svg',
                ),
              ),
              SizedBox(
                height: 40,
                child: Text(
                  'Please fill the input below',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Color(0xffA1A1A1),
                    fontSize: 15,
                    fontWeight: FontWeight.normal
                  ),
                ),
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
                    prefixIcon: Icon(CupertinoIcons.mail,
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
                      hintText: 'Email Address',
                      hintStyle: TextStyle(
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey.withOpacity(0.7),
                      )),
                ),
              ),
              SizedBox(
                height: 16,
              ),

              ///Password field///
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: TextField(
                  obscureText: obscured,
                  controller: passwordController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      prefixIcon: Icon(CupertinoIcons.lock,
                        size: 22,
                        color: Colors.grey.withOpacity(0.5),),
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
                      hintText: 'Enter password',
                      hintStyle: TextStyle(
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey.withOpacity(0.7),
                      )),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              InkWell(
                onTap: () async {
                  emailText = emailController.text;
                  bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(emailText);

                  if (emailText != "" && emailValid) {
                    final list = await FirebaseAuth.instance
                        .fetchSignInMethodsForEmail(emailText);
                    if (!mounted) return;
                    if (list.isNotEmpty) {
                      try {
                        FirebaseAuth.instance.sendPasswordResetEmail(
                            email: emailController.text);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "A link has been sent to your email successfully!")));
                      } on Exception catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("User not found!")));
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Email Field is empty/invalid!")));
                  }
                },
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff004040),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              InkWell(
                enableFeedback: true,
                onTap: () async {

                  AuthService().customSnackBarMessenger(context, 'Signing In...');
                  await AuthService().signInWithEmailPassword(
                      context, emailController.text, passwordController.text);
                  if (!mounted) return;
                  if (FirebaseAuth.instance.currentUser != null) {

                   Navigator.pushNamed(context, HomePage.routeName);
                  }
                },
                child: SignInButton(
                  width: width,
                  height: 56,
                  text: 'Sign In',
                )
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                       Navigator.pushNamed(context, SignUpPage.routeName);
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff004040),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
