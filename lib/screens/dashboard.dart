import 'dart:async';

import 'package:fit_check/constants/colors.dart';
import 'package:fit_check/constants/strings.dart';
import 'package:fit_check/screens/profile_creation.dart';
import 'package:fit_check/widgets/goalWidget.dart';
import 'package:fit_check/widgets/graph.dart';
import 'package:fit_check/widgets/optionsWidget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late TextEditingController weightInputController, goalInputController;
  String currentWeight = "Add today's weight";
  final String WKEY = "previousWeightKey", NEXTGOALKEY = "nextGoalKey";
  late String formattedTime;
  late String? usernamePref="user", passwordPref;
  TextEditingController nameChangeController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formattedTime = DateFormat('kkmmss').format(DateTime.now());
    weightInputController = TextEditingController();
    goalInputController = TextEditingController();
    getCurrentWeightValueAndNameAndPassword();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    weightInputController.dispose();
    goalInputController.dispose();
  }

  void getCurrentWeightValueAndNameAndPassword() async {
    var prefs = await SharedPreferences.getInstance();
    String? previousWeight = prefs.getString(WKEY);
    usernamePref = prefs.getString(ProfileCreationState.NAMEKEY);
    passwordPref = prefs.getString(ProfileCreationState.PASSKEY);
    currentWeight = previousWeight ?? "Add today's weight";
    futureGoal = prefs.getString(NEXTGOALKEY) as double;
    setState(() {});
  }

  double previousGoal = 0, futureGoal = 0;

  void editNameFunc() => showGeneralDialog(
        context: context,
        barrierColor: Colors.black54,
        barrierDismissible: true,
        barrierLabel: 'Label',
        pageBuilder: (_, __, ___) {
          return Align(
            alignment: Alignment.center,
            child: Container(
              width: 220,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Material(
                    child: TextField(
                      controller: nameChangeController,
                      decoration: const InputDecoration(
                        hintText: "Enter new name",
                        hintStyle: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var pref = await SharedPreferences.getInstance();
                      pref.setString(ProfileCreationState.NAMEKEY,
                          nameChangeController.text);
                      setState(() {});
                    },
                    child: Text(
                      "Change",
                      style: TextStyle(
                        fontSize: 17,
                        color: appColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
  Future openSettingsModal() => showGeneralDialog(
        context: context,
        barrierColor: Colors.black54,
        barrierDismissible: true,
        barrierLabel: 'Label',
        pageBuilder: (_, __, ___) {
          return Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 40, top: 75),
              child: Container(
                width: 180,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OptionsWidget(
                        btnText: 'Edit Name', toDoFunction: editNameFunc),
                    OptionsWidget(
                        btnText: 'Edit Password', toDoFunction: editNameFunc),
                    OptionsWidget(
                        btnText: 'Logout', toDoFunction: editNameFunc),
                  ],
                ),
              ),
            ),
          );
        },
      );

  void submit() {
    String inputWeightString = weightInputController.text.toString();
    if (int.parse(inputWeightString) > 500 ||
        int.parse(inputWeightString) < 30) {
      Fluttertoast.showToast(
        msg: "Enter a valid weight value!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 14,
      );
    } else {
      Navigator.of(context).pop(inputWeightString);
    }
    weightInputController.clear();
  }

  Future<String?> openAddWeightModal() => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            "Add weight",
            style: TextStyle(
              color: appColor,
            ),
          ),
          content: TextField(
            autofocus: true,
            keyboardType: TextInputType.number,
            onSubmitted: (_) => submit(),
            decoration: const InputDecoration(
              hintText: "Enter weight (in Kg)",
              hintStyle: TextStyle(
                fontWeight: FontWeight.w300,
              ),
            ),
            controller: weightInputController,
          ),
          actions: [
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  submit();
                },
                child: Text(
                  (currentWeight == "Add today's weight") ? "Add" : "Update",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: appColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  void addGoal() {
    String updateGoal = goalInputController.text;
    if (int.parse(updateGoal) > 500 || int.parse(updateGoal) < 30) {
      Fluttertoast.showToast(
        msg: "Enter a valid weight value!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 14,
      );
    } else {
      Navigator.of(context).pop(updateGoal);
    }
    goalInputController.clear();
  }

  Future<String?> openAddNextGoalModal() => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            "Add Goal",
            style: TextStyle(
              color: appColor,
            ),
          ),
          content: TextField(
            autofocus: true,
            keyboardType: TextInputType.number,
            onSubmitted: (_) => addGoal(),
            decoration: const InputDecoration(
              hintText: "Enter weight (in Kg)",
              hintStyle: TextStyle(
                fontWeight: FontWeight.w300,
              ),
            ),
            controller: goalInputController,
          ),
          actions: [
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  addGoal();
                },
                child: Text(
                  (futureGoal == 0) ? "Add" : "Update",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: appColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  String weightScoreCalculator() {
  int weightScore = 0;
    if (futureGoal != 0) {
      if (futureGoal >= previousGoal) {
        setState(() {
          weightScore = ((int.parse(currentWeight) / futureGoal) * 100) as int;
        });
      }
      return "Your weight score is: $weightScore";
    } else {
      return "Enter future goal (tap it), to get score.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          appTitle,
          style: TextStyle(
            fontSize: 28,
            color: appColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              openSettingsModal();
            },
            icon: Icon(
              Icons.settings_rounded,
              color: appColor,
            ),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Hi ${(usernamePref == null) ? 'user' : usernamePref}",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w400,
                    color: appColor,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15,
              ),
              child: Row(
                children: [
                  GoalWidget(
                    title: "Previous Goal",
                    value: previousGoal.toString(),
                  ),
                  Expanded(
                    flex: 5,
                    child: GestureDetector(
                      onTap: () async {
                        String? inputWeight = await openAddNextGoalModal();
                        setState(() {
                          previousGoal = futureGoal;
                          futureGoal = double.parse(inputWeight!);
                          weightScoreCalculator();
                        });
                        var prefs = await SharedPreferences.getInstance();
                        prefs.setString(NEXTGOALKEY, futureGoal.toString());
                      },
                      child: GoalWidget(
                        title: "Next Goal",
                        value: futureGoal.toString(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 5,
                      blurRadius: 5,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(25),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 35),
                child: Column(
                  children: [
                    const Text(
                      "Current weight (in Kg)",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      currentWeight,
                      style: TextStyle(
                        fontSize: 44,
                        color: appColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      weightScoreCalculator(),
                      style: const TextStyle(fontSize: 17),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 40,
              ),
              child: LineChartWidget(),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          right: 25,
          bottom: 30,
        ),
        child: FloatingActionButton(
          onPressed: () async {
            String? inputWeight = await openAddWeightModal();
            // if (inputWeight == null || currentWeight.isEmpty) {
            //   return;
            // }
            setState(() {
              currentWeight = inputWeight ?? currentWeight;
            });
            var prefs = await SharedPreferences.getInstance();
            prefs.setString(WKEY, currentWeight);
          },
          shape: const CircleBorder(),
          backgroundColor: appColor,
          child: Icon(
            (currentWeight == "Add today's weight")
                ? Icons.add_rounded
                : Icons.edit_rounded,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
