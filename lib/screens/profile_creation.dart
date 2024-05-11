import 'package:fit_check/constants/colors.dart';
import 'package:fit_check/constants/strings.dart';
import 'package:fit_check/screens/dashboard.dart';
import 'package:fit_check/screens/login.dart';
import 'package:fit_check/widgets/customInputField.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileCreation extends StatefulWidget {
  bool isLoad;
  ProfileCreation({super.key, required this.isLoad});

  @override
  State<ProfileCreation> createState() => _ProfileCreationState();
}

class _ProfileCreationState extends State<ProfileCreation> {
  bool isAgreed = false;
  late bool isMailValid, isUsernameValid, isPasswordValid;
  TextEditingController usernameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late String inputMail, inputName, inputPassword;

  void prefStore(bool isAgreed) async{
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool("isLoad", isAgreed);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loader();
  }
  void loader() async {
    var prefs = await SharedPreferences.getInstance();
    widget.isLoad=prefs.getBool("isLoad")!;
    setState(() {});
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
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: "Enter mail",
                        ),
                        onChanged: (value) =>
                            setState(() => inputMail = value),
                      ),
                    ),
                    CustomInputField(
                      labelText: 'Enter username',
                      textEditingController: usernameController,
                    ),
                    CustomInputField(
                      labelText: 'Enter password',
                      textEditingController: passwordController,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextButton(
                      onPressed: () {
                        if (mailController.toString().contains("@") &&
                            mailController.toString().length >= 4) {
                          isMailValid = true;
                        } else {
                          isMailValid = false;
                        }
                        String inputPassword = passwordController.toString();
                        if (passwordController.value == "a") {}
                        if (isAgreed) {
                          prefStore(isAgreed);
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
}
