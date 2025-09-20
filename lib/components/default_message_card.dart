import 'package:flutter/material.dart';

import '../config/utils/app_colors.dart';

class DefaultMessageCard extends StatelessWidget {
  final String sign;
  final String title;
  final String subTitle;
  const DefaultMessageCard(
      {super.key,
      required this.sign,
      required this.title,
      required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: (35),
            backgroundColor: AppColors.lightPrimary.withOpacity(0.3),
            child: CircleAvatar(
              backgroundColor: AppColors.greySoft1,
              radius: (30),
              child: Text(
                sign,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: AppColors.blueLight, fontSize:  26),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Column(
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                     ),
                ),
                const SizedBox(
                  height: 10,
                ),
                /*  Text(
                  subTitle.tr(context),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: AppValues.font * 20,
                      fontWeight: FontWeight.w400,
                      color: AppColors.greyMedi),
                ),*/
              ],
            ),
          )
        ],
      ),
    );
  }
}
