import 'dart:async';
import 'dart:math';

import 'package:fit_check/constants/colors.dart';
import 'package:fit_check/constants/strings.dart';
import 'package:fit_check/widgets/goalWidget.dart';
import 'package:fit_check/widgets/graph.dart';
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
  late TextEditingController weightInputController;
  String currentWeight = "Add today's weight";
  final String WKEY = "previousWeightKey";
  late String formattedTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formattedTime = DateFormat('kkmmss').format(DateTime.now());
    weightInputController = TextEditingController();
    getCurrentWeightValue();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    weightInputController.dispose();
  }

  void getCurrentWeightValue() async {
    var prefs = await SharedPreferences.getInstance();
    String? previousWeight = prefs.getString(WKEY);
    currentWeight = previousWeight ?? "Add today's weight";
    setState(() {});
  }

  double previousGoal = 0, futureGoal = 0;
  Future openSettingsModal() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          actions: [
            Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text("Edit name"),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text("Edit password"),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text("Logout"),
                  ),
                ],
              ),
            ),
          ],
        ),
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
  int weightScore = 0;
  String weightScoreCalculator(){
    if(futureGoal!=0 && previousGoal != 0){
      if(futureGoal>=previousGoal){
        weightScore = ((int.parse(currentWeight)/futureGoal)*100) as int;
      }
      return "Your weight score is: $weightScore";
    }
    else{
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
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15,),
              child: Row(
                children: [
                  GoalWidget(title: "Previous Goal", value: previousGoal.toString(), canEdit: false),
                  GoalWidget(title: "Next Goal", value: futureGoal.toString(), canEdit: true),
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
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 35),
                child: Column(
                  children: [
                    const Text("Current weight (in Kg)",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.black87,
                      ),
                    ),
                    Text(currentWeight,style: TextStyle(
                      fontSize: 44,
                      color: appColor,
                      fontWeight: FontWeight.w400,
                    ),),
                    const SizedBox(height: 15,),
                    Text(weightScoreCalculator(), style: const TextStyle(
                      fontSize: 17
                    ),),
                  ],
                ),
              ),
            ),
            const Padding(

              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 40,),
              child: LineChartWidget(),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10,),
              child: GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    color: appColor,
                    borderRadius: BorderRadius.circular(12)
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20,),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.history_rounded, color: Colors.white,),
                          SizedBox(width: 10,),
                          Text("History", style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.w400,
                          ),),
                        ],
                      ),
                      Transform.rotate(
                        angle: 90 * pi/180,
                        child: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white,),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
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
    );
  }
}
