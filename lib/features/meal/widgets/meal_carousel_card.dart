import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/utils/app_colors.dart';
import '../../../data/models/meal_model.dart';
import '../../likes/cubit/likes_cubit.dart';
import '../views/meal_details_view.dart';

class MealCarouselCard extends StatefulWidget {
  final Meal meal;

  const MealCarouselCard({super.key, required this.meal});

  @override
  State<MealCarouselCard> createState() => _MealCarouselCardState();
}

class _MealCarouselCardState extends State<MealCarouselCard> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return BlocProvider(
      create: (_) => LikesCubit()..listenToLikes(widget.meal.idMeal),
      child: Stack(
      children: [
        Positioned(
            left: 10,
            right: 10,
            bottom: 280,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 50.w,
                height: 0.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 40,
                        spreadRadius: 20,
                      )
                    ]),
              ),
            )),
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      MealDetailsView(mealId: widget.meal.idMeal),
                ));
          },
          child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.all(8.0.w),
                child: ExtendedImage.network(
                  height: 280.h,
                  width: 300.w,
                  widget.meal.strMealThumb,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(40.r),
                ),
              )),
        ),
        Positioned(
          bottom: 170,
          left: 70,
          child: SizedBox(
            width: 180.w,
            height: 100.h,
            child: Text(
              widget.meal.strMeal,
              style: theme.bodyLarge?.copyWith(
                  color: Colors.blue,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),

        Positioned(
          bottom: 120,
          left: 50,
          right: 50,
          child: BlocBuilder<LikesCubit, LikesState>(
            builder: (context, state) {
              if (state is LikesLoaded) {
                return Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        state.isLiked ? Icons.favorite : Icons.favorite_border,
                        color: state.isLiked ? Colors.red : Colors.black,
                        size: 30,
                      ),
                      onPressed: () {
                        context.read<LikesCubit>().toggleLike(widget.meal.idMeal);
                      },
                    ),
                    Text("${state.count}", style: theme.bodySmall),
                     SizedBox(width: 50.w),
                    const Icon(Icons.telegram_outlined, size: 30, color: AppColors.secondery),
                    Text("0", style: theme.bodySmall),
                  ],
                );
              }
              return const SizedBox();
            },
          )
          ,
        ),
        //  Positioned(
        //   left: 210,
        //   top: 20,
        //   child: BlocBuilder<FavouriteCubit, FavouriteState>(
        //     builder: (context, state) {
        //       final isFavorite = context.read<FavouriteCubit>().isFavorite(widget.meal.idMeal);
        //       return GestureDetector(
        //         onTap: () => context
        //             .read<FavouriteCubit>()
        //             .addToFavourite(widget.meal),
        //         child: Icon(
        //           isFavorite ? Icons.favorite : Icons.favorite_border,
        //           color: isFavorite ? Colors.red : Colors.black,
        //           size: 30,
        //         ),
        //       );
        //     },
        //   ),
        // ),
      ],
    ),
);
  }

}
