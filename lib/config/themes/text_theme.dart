import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';

class AppTextTheme {
  static TextTheme lightTextTheme = GoogleFonts.museoModernoTextTheme( const TextTheme(
    displayLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.normal,
        color: AppColors.black), // Page titles'
    bodyLarge:
        TextStyle(fontSize: 14, color: AppColors.primary), // Paragraph text

    titleLarge:TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w500,
        color: AppColors.secondery) ,
    titleMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: AppColors.secondery), // List titles
    titleSmall: TextStyle(
        fontSize: 16,
        color: AppColors.black), // List item titles, Important text snippets
    bodySmall: TextStyle(
        fontSize: 13, color: AppColors.secondery), // Secondary text, Captionstons, Tabs
  ));
  static TextTheme darkTextTheme = GoogleFonts.museoModernoTextTheme( const TextTheme(
    displayLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.normal,
        color: AppColors.white), // Page titles
    bodyLarge:
        TextStyle(fontSize: 14, color: AppColors.primary), // Paragraph text
    titleMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.white), // List titles
    titleSmall: TextStyle(
        fontSize: 16,
        color: AppColors.white), // List item titles, Important text snippets
    bodySmall: TextStyle(
        fontSize: 14, color: AppColors.secondery), // Secondary text, Captions
  ));
}
