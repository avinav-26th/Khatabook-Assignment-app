import 'package:fit_check/constants/colors.dart';
import 'package:flutter/material.dart';

class OptionsWidget extends StatelessWidget {
  final String btnText;
  final void Function()? toDoFunction;
  const OptionsWidget({
    super.key,
    required this.btnText,
    required this.toDoFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
          onPressed: toDoFunction,
          child: Text(
            btnText,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: appColor,
            ),
          ),
        ),
        const Divider(
          height: 1,
          color: Colors.grey,
        ),
      ],
    );
  }
}
