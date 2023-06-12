import 'package:carcareuser/.core/strings.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String? matchtext;
  final String? textType;
  
  const PasswordField({
    super.key,
    required this.controller,
    required this.labelText,
    this.textType, 
    this.matchtext, 
    
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

bool passenable = true;

class _PasswordFieldState extends State<PasswordField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10,2,10,2),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: TextInputType.visiblePassword,
        validator: (value) {
          if(widget.textType=='password'){
            password=value;
          }
          if (value == null || value.isEmpty) {
            return 'field is mandatory';
          }
          else if (value.length<8) {
            return 'password must contain 8 or more charcters';
          }

          else if(password!=null){
            if(password!=value){
                return 'password doesnt match';
            }
         
          }
          return null;
        },
        obscureText: passenable,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock_outlined),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          labelText: widget.labelText,
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                if (passenable) {
                  passenable = false;
                } else {
                  passenable = true;
                }
              });
            },
            icon: Icon(
                passenable == true ? Icons.visibility : Icons.visibility_off),
          ),
        ),
      ),
    );
  }
}
