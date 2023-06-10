import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String validateContact;
  final String validateAlpha;
  final IconData icon;
  final TextInputType keyType;
  final bool isValidate;
  final bool isContact;
  final bool isAlpha;


  const TextFieldWidget({
    super.key,
    required this.controller,
    required this.labelText,
    this.validateContact = 'Number Must be 10 digits',
    this.validateAlpha = 'only Alphabets Allowed',
    required this.keyType,
    this.isValidate = false,
    this.isContact = false,
    this.isAlpha = false, 
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10,2,10,2),
      child: TextFormField(
        controller: controller,
        keyboardType: keyType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'field is mandatory';
          } else if (isContact && value.length != 10) {
            return validateContact;
          }else if (isAlpha&&!RegExp(r'^[a-z]+$').hasMatch(value)) {
            return validateAlpha;
          }
          return null;
        },
        decoration: InputDecoration(
            prefixIcon: Icon(icon),
            fillColor: Colors.white,
            filled: true,
          
            labelText: labelText),
      ),
    );
  }
}
