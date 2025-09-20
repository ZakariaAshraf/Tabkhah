import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? suffixText;
  final void Function(String)? onChanged;
  final bool isPassword;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.suffixText,
    this.onChanged,
    this.isPassword = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscure = true;

  @override
  void initState() {
    super.initState();
    _obscure = widget.isPassword; // only obscure if it's a password field
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        style: const TextStyle(color: Colors.black),
        onChanged: widget.onChanged,
        controller: widget.controller,
        obscureText: _obscure, // ✅ apply obscure
        decoration: InputDecoration(
          filled: true,
          hintText: widget.hintText,
          suffixText: widget.suffixText,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black.withOpacity(0.2)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black.withOpacity(0.4)),
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
            icon: Icon(
              _obscure ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                _obscure = !_obscure;
              });
            },
          )
              : null,
        ),
        validator: (val) =>
        val == null || val.isEmpty ? 'Please fill this' : null,
      ),
    );
  }
}
