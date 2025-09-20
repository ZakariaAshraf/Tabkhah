import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
 final TextEditingController controller;
 final String hintText;
 final String ?suffixText;
 final void Function(String)? onChanged;
  const CustomTextField({super.key, required this.controller, required this.hintText, this.suffixText, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        keyboardType: const TextInputType.numberWithOptions(),
        onChanged: onChanged,
        controller: controller,
        decoration:  InputDecoration(
            suffixText: suffixText,
            hintText: hintText ,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color:Colors.black.withOpacity(0.2))),
            focusedBorder:  OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.4))),

        ),
        validator:
            (val) => val == null || val.isEmpty ? 'Please fill this ' : null,
      ),
    );
  }
}
