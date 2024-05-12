import 'package:fit_check/screens/intro.dart';
import 'package:fit_check/screens/profile_creation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/colors.dart';
import '../constants/strings.dart';
import '../widgets/customInputField.dart';
import 'dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final FORMKEY = GlobalKey<FormState>();

  String? nameValidationFunc(String? value) {
    if (value == null || value.isEmpty) {
      return "Name cannot be blank";
    } else if (!RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
      return "Enter proper name";
    } else {
      return null;
    }
  }

  String? passwordValidationFunc(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter password";
    } else if (!RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
        .hasMatch(value)) {
      return "Enter a valid password";
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xff2b98cf),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 50,
          horizontal: 25,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            Text(
              profileScrWelcome,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 40,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.white,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                child: Form(
                  key: FORMKEY,
                  child: Column(
                    children: [
                      CustomInputField(
                        labelText: 'Enter username',
                        textEditingController: usernameController,
                        inputType: TextInputType.text,
                        isPassword: false,
                        isValid: nameValidationFunc,
                      ),
                      CustomInputField(
                        labelText: 'Enter password',
                        textEditingController: passwordController,
                        inputType: TextInputType.visiblePassword,
                        isPassword: true,
                        isValid: passwordValidationFunc,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      TextButton(
                        onPressed: () async {
                          if (FORMKEY.currentState!.validate()) {
                            Fluttertoast.showToast(
                              msg: "Logged in successfully",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: const Color(0xff13A01B),
                              textColor: Colors.white,
                              fontSize: 14,
                            );
                            var loginSharedPref =
                                await SharedPreferences.getInstance();
                            loginSharedPref.setString(ProfileCreationState.NAMEKEY, usernameController.text);
                            loginSharedPref.setString(ProfileCreationState.PASSKEY, passwordController.text);
                            loginSharedPref.setBool(
                                IntroScreenState.LOGINKEY, true);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Dashboard()),
                            );
                          }
                        },
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          backgroundColor: appColor,
                          elevation: 5,
                        ),
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 3, horizontal: 35),
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileCreation()),
                          );
                        },
                        child: Text(
                          "Register for a new account",
                          style: TextStyle(
                            fontSize: 16,
                            color: appColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
