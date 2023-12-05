import 'package:flutter/material.dart';

class MyTextFormWidget extends StatelessWidget {
  const MyTextFormWidget(
      {required this.controller,
      required this.obscureText,
      required this.focusNode,
      required this.validator,
      required this.prefIcon,
      required this.labelText,
      required this.textInputAction,
      super.key});

  // Controller for the text field
  final TextEditingController controller;
  // to obscure text or not bool
  final bool obscureText;
  // FocusNode for input
  final FocusNode focusNode;
  // Validator function
  final String? Function(String?)? validator;
  // Prefix icon for input form
  final Icon prefIcon;
  // label for input form
  final String labelText;
  // The keyword action to display
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        // Input with border outlined
        border: const OutlineInputBorder(
          // Make border edge circular
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        label: Text(labelText),
        prefixIcon: prefIcon,
      ),
      focusNode: focusNode,
      textInputAction: textInputAction,
      obscureText: obscureText,
      validator: validator,
    );
  }
}
