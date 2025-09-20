
import 'package:flutter/material.dart';

import '../../../../config/utils/app_colors.dart';


class ProfileButton extends StatelessWidget {
  final String title;
  final Function function;
  final IconData iconData;
  const ProfileButton(
      {super.key,
      required this.title,
      required this.function,
      required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0.5,
        child: ListTile(
          onTap: () => function(),
          trailing: Icon(
            iconData,
            color: AppColors.primary,
          ),
    
          title: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: AppColors.black),
          ),
        ));
  }
}
