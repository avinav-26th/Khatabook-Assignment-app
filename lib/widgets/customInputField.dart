import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  final String labelText;
  final TextEditingController textEditingController;
  final TextInputType inputType;
  final bool isPassword;
  final String? Function(String?) isValid;

  const CustomInputField({
    super.key,
    required this.labelText,
    required this.textEditingController,
    required this.inputType,
    required this.isPassword,
    required this.isValid,
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
        validator: widget.isValid,
        obscureText: widget.isPassword,
        keyboardType: widget.inputType,
        controller: widget.textEditingController,
        decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          labelText: widget.labelText,
        ),
      ),
    );
  }
}
