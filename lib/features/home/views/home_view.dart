import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tab5ah/config/utils/app_colors.dart';
import 'package:tab5ah/features/category_filteration/cubit/filter_cubit.dart';
import 'package:tab5ah/features/meal/widgets/meal_carousel_card.dart';
import 'package:tab5ah/features/search/views/search_screen.dart';
import '../widgets/custom_drawer_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _advancedDrawerController = AdvancedDrawerController();
  final PageController _pageController = PageController();
  double currentPage = 0;

  @override
  void initState() {
    _pageController.addListener(
      () {
        setState(() {
          currentPage = _pageController.page ?? 1;
        });
      },
    );
    context.read<FilterCubit>().filterByCategory("Breakfast");
    _selectedCategory = "Breakfast";
    super.initState();
  }

  String? _selectedCategory;

  static const List<String> categories = [
    'Breakfast',
    'Beef',
    'Chicken',
    'Seafood',
    'Dessert',
    'Pasta',
    'Vegetarian',
    'Vegan',
    'Pork',
    'Lamb'
  ];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;

    return AdvancedDrawer(
      backdropColor: AppColors.secondery,
      controller: _advancedDrawerController,
      drawer: const CustomDrawerView(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 10),
                  child: Semantics(
                    label: 'Menu',
                    onTapHint: 'expand drawer',
                    child: value.visible
                        ? const Icon(Icons.clear)
                        : ImageIcon(
                            const AssetImage("assets/images/menu.png"),
                            color: AppColors.secondery,
                            key: ValueKey<bool>(value.visible),
                          ),
                  ),
                );
              },
            ),
          ),
          title: Text(
            "Tabkhah",
            style: theme.titleLarge,
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.search_outlined,
                color: AppColors.secondery,
                size: 30,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchScreen(),
                  ),
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                 SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  height: 60,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                       SizedBox(width: 8.w),
                      ...categories.map((category) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: FilterChip(
                            side: BorderSide.none,
                            showCheckmark: false,
                            label: Text(
                              category,
                            ),
                            selected: _selectedCategory == category,
                            onSelected: (selected) {
                              setState(() {
                                _selectedCategory = selected ? category : null;
                              });
                              if (selected) {
                                context
                                    .read<FilterCubit>()
                                    .filterByCategory(category);
                              }
                            },
                            labelStyle: TextStyle(
                              decoration: _selectedCategory == category
                                  ? TextDecoration.underline
                                  : TextDecoration.none,
                              fontSize: _selectedCategory == category ? 18.sp : 13.sp,
                              color: _selectedCategory == category
                                  ? Colors.black
                                  : const Color(0xff7B4019),
                            ),
                          ),
                        );
                      }),
                       SizedBox(width: 8.w),
                    ],
                  ),
                ),
                 SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  height: 650.h,
                  width: 375.w,
                  child: BlocBuilder<FilterCubit, FilterState>(
                    builder: (context, state) {
                      if (state is FilterError) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Error: ${state.error}'),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () => context
                                    .read<FilterCubit>()
                                    .filterByCategory(_selectedCategory!),
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        );
                      }
                      if (state is FilterLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is FilterSuccess) {
                        final meals = state.meals;
                        return CarouselSlider(
                          items: meals
                              .map((meal) => MealCarouselCard(meal: meal))
                              .toList(),
                          options: CarouselOptions(
                            height: ScreenUtil().screenHeight,
                            enlargeCenterPage: true,
                            enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    if (_advancedDrawerController.value.visible) {
      _advancedDrawerController.hideDrawer();
    } else {
      _advancedDrawerController.showDrawer();
    }
  }
}
// return PageView.builder(
//   itemBuilder: (context, index) {
//     final scale = 1 - (currentPage-index).abs() * 1;
//     return Transform.scale(
//       scale: scale.clamp(0.5, 1.0)  ,
