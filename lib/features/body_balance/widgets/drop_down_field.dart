import 'package:flutter/material.dart';

class CustomDropDownField extends StatelessWidget {
  final String? value;
  final String label;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const CustomDropDownField(
      {super.key,
      this.value,
      required this.label,
      required this.items,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: DropdownButtonFormField(
        elevation: 14 ,
        value: value,
        decoration: InputDecoration(
          hintText: label,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color:Colors.black.withOpacity(0.2))),
          focusedBorder:  OutlineInputBorder(borderSide: BorderSide(color: Colors.black.withOpacity(0.4))),
        ),
        items: items
            .map((item) => DropdownMenuItem(value: item, child: Text(item)))
            .toList(),
        onChanged: onChanged,
        validator: (val) => val == null ? 'please choose $label' : null,
      ),
    );
  }
}
