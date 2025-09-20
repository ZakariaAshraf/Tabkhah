import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final Color? color;
  final void Function()? onTap;
  const PrimaryButton({super.key, required this.title, this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: 327,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        child:Center(
          child: Text(
            title,
            style:  GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
