import 'package:flutter/material.dart';
import 'package:tab5ah/config/utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final void Function() onTap;
  final Color? color;
  const CustomButton({super.key, required this.title, required this.onTap,this.color});

  @override
  Widget build(BuildContext context) {
    var theme =Theme.of(context);
    return GestureDetector(
      onTap:onTap ,
      child: Container(
        height: 50,
        width: 250,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.black),
          borderRadius: BorderRadius.circular(10),
          color: color ?? AppColors.primary
        ),
        child:  Center(
          child: Text(
            title,
            style: theme.textTheme.titleLarge!.copyWith(color: AppColors.secondery),
          ),
        ),
      ),
    );
  }
}
