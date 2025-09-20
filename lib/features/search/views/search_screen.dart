import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tab5ah/features/meal/widgets/meal_overview.dart';
import '../cubit/search_cubit.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: CupertinoSearchTextField(
                controller: _searchController,
                onChanged: (value) {
                  context.read<SearchCubit>().search(value);
                },
                placeholder: 'Search for meals...',
              ),
            ),
            // const SizedBox(height: 10),
            // FilterTypesSection(
            //   onCategorySelected: (category) {
            //     setState(() {
            //       _selectedCategory = category;
            //     });
            //   },
            // ),
            const SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {

                  if (state is SearchInitial) {
                    return const Center(
                      child: Text('Start typing to search for meals'),
                    );
                  } else if (state is SearchLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SearchError) {
                    return Center(child: Text(state.message));
                  } else if (state is SearchSuccess) {
                    if (state.meals.isEmpty) {
                      return const Center(
                        child: Text('No meals found matching your search'),
                      );
                    }

                    return ListView.builder(
                      itemCount: state.meals.length,
                      itemBuilder: (context, index) {
                        final meal = state.meals[index];
                        return MealOverview(meal: meal);
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}