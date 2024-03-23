import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomeTextFormField extends StatelessWidget {
  final String hint;
  final TextEditingController myController;
  const CustomeTextFormField(
      {super.key, required this.hint, required this.myController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: myController,
      validator: (value) {
        if (value == "") {
          return "رجاء املأ الحقل";
        }
      },
      decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
              color: Colors.grey[500],
              fontSize: 18,
              fontWeight: FontWeight.normal),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)))),
    );
  }
}

class CustomePhoneNumberTextFormField extends StatelessWidget {
  final String hint;
  final TextEditingController myController;
  const CustomePhoneNumberTextFormField(
      {super.key, required this.hint, required this.myController});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        keyboardType: TextInputType.number,
        textAlign: TextAlign.left,
        controller: myController,
        validator: (value) {
          if (value == "") {
            return "رجاء املأ الحقل";
          }
          if (value!.length != 9) {
            return "يجب أن يكون الرقم من 9 خانات";
          }
          final n = num.tryParse(value);
          if (n == null) {
            return 'رقم خاطئ';
          }
        },
        decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
                color: Colors.grey[500],
                fontSize: 18,
                fontWeight: FontWeight.normal),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)))),
      ),
    );
  }

  numberValidator(String value) {
    if (value == null) {
      return null;
    }
    final n = num.tryParse(value);
    if (n == null) {
      return '"$value" is not a valid number';
    }
    return null;
  }
}
