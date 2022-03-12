import 'package:flutter/material.dart';

class GeneralInputField extends StatelessWidget {
  const GeneralInputField({Key key,this.hintText,this.controller,this.validator,this.onSaved,this.fillColor,this.inputType}) : super(key: key);

  final hintText;
  final TextEditingController controller;
  final ValueChanged<String> validator;
  final ValueChanged<String> onSaved;
  final Color fillColor;
  final TextInputType inputType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      onSaved: onSaved,
      keyboardType: inputType,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintStyle: TextStyle(color: Colors.grey[800]),
          hintText: hintText,
          fillColor: fillColor,
      ),
    );
  }
}
