import 'package:fit_check/constants/colors.dart';
import 'package:fit_check/constants/strings.dart';
import 'package:fit_check/screens/dashboard.dart';
import 'package:fit_check/screens/login.dart';
import 'package:fit_check/screens/profile_creation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key, });

  @override
  State<IntroScreen> createState() => IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
  static const LOGINKEY="login", REGISTERKEY="register";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    skipToDashboard();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //app bar row
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Text(
                appTitle,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
              ),
              child: Text(
                "$introScrSlogan 🏃",
                style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              introScrDescription,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black87,
              ),
            ),
            SizedBox(
              height: 330,
              child: SvgPicture.asset(
                "assets/images/intro_filler.svg",
                semanticsLabel: "Intro filler image",
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileCreation()),
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: appColor,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 60,
                      vertical: 5,
                    ),
                    child: Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                        );
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 20,
                          color: appColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void skipToDashboard() async{
    var sharedPref = await SharedPreferences.getInstance();
    var isLoggedIn = sharedPref.getBool(LOGINKEY);
    var isRegistered = sharedPref.getBool(REGISTERKEY);
    late bool loginStatus, registeredStatus;
    if(isLoggedIn!=null){
      loginStatus = isLoggedIn;
    }
    if(isRegistered!=null){
      registeredStatus = isRegistered;
    }
    if(loginStatus || registeredStatus){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const Dashboard()),
      );
    }
  }
  }

