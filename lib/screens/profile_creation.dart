import 'package:fit_check/constants/colors.dart';
import 'package:fit_check/constants/strings.dart';
import 'package:fit_check/screens/dashboard.dart';
import 'package:fit_check/screens/intro.dart';
import 'package:fit_check/screens/login.dart';
import 'package:fit_check/widgets/customInputField.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileCreation extends StatefulWidget {
  const ProfileCreation({
    super.key,
  });

  @override
  State<ProfileCreation> createState() => ProfileCreationState();
}

class ProfileCreationState extends State<ProfileCreation> {
  bool isAgreed = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  static const  NAMEKEY="username", PASSKEY="password";

  final FORMKEY = GlobalKey<FormState>();

  String? emailValidationFunc(String? value) {
    if (value == null || value.isEmpty) {
      return "Email cannot be blank";
    } else if (!RegExp(r'^[\w-]+@([\w-]+\.)+\w{2,4}').hasMatch(value!)) {
      return "Enter proper email";
    } else {
      return null;
    }
  }

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
          vertical: 35,
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
                        labelText: "Enter mail",
                        textEditingController: mailController,
                        inputType: TextInputType.emailAddress,
                        isPassword: false,
                        isValid: emailValidationFunc,
                      ),
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
                            if (isAgreed) {
                              Fluttertoast.showToast(
                                msg: "Registered successfully",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: const Color(0xff13A01B),
                                textColor: Colors.white,
                                fontSize: 14,
                              );
                              var registerSharedPref =
                                  await SharedPreferences.getInstance();
                              registerSharedPref.setString(NAMEKEY, usernameController.text);
                              registerSharedPref.setString(PASSKEY, passwordController.text);
                              registerSharedPref.setBool(
                                  IntroScreenState.REGISTERKEY, true);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Dashboard()),
                              );
                            } else {
                              Fluttertoast.showToast(
                                msg: "Please agree to our terms!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.redAccent,
                                textColor: Colors.white,
                                fontSize: 14,
                              );
                            }
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
                            "Register",
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
                                builder: (context) => const LoginScreen()),
                          );
                        },
                        child: Text(
                          "I have an account",
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
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 30,
              ),
              child: Text(
                profileScrDataConsent,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Transform.scale(
                  scale: 1.2,
                  child: Checkbox(
                    checkColor: Colors.white,
                    side: const BorderSide(width: 0.2),
                    splashRadius: 40,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    fillColor:
                        MaterialStateColor.resolveWith((states) => appColor),
                    shape: const CircleBorder(),
                    value: isAgreed,
                    onChanged: (bool? value) {
                      setState(() {
                        isAgreed = value!;
                      });
                    },
                  ),
                ),
                Text(
                  profileScrTerms,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  void storeNameAndPassword() async{
    var sharedPref = await SharedPreferences.getInstance();
    var usernamePref = sharedPref.getString(NAMEKEY);
    var passwordPref = sharedPref.getString(PASSKEY);
  }
}
