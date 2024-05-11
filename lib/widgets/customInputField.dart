import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  final String labelText;
  final TextEditingController textEditingController;

  const CustomInputField({
    super.key,
    required this.labelText,
    required this.textEditingController,
  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          labelText: widget.labelText,
        ),
      ),
    );
  }
}
