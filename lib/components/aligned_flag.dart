import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AlignedFlag extends StatelessWidget {
  final String title;
  final double width;
  const AlignedFlag({super.key, required this.title, required this.width});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: width,
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: Color(0xff7B4019),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(25),
                bottomRight: Radius.circular(25)),
          ),
          child: Text(
            title,
            style: GoogleFonts.museoModerno(
                color: const Color(0xffFFEEA9), fontSize: 16),
          ),
        ),
      ),
    );
  }
}
