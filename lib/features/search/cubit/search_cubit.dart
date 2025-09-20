import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import '../../../data/models/meal_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final _searchController = StreamController<String>();
  StreamSubscription<String>? _searchSubscription;
  Timer? _debounce;

  SearchCubit() : super(SearchInitial()) {
    _searchSubscription = _searchController.stream
        .distinct()
        .debounceTime(const Duration(milliseconds: 500))
        .listen((query) => _performSearch(query));
  }

  void search(String query) {
    _searchController.add(query);
  }

  Future<void> _performSearch(String query) async {
    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());

    try {
      final response = await http.get(
          Uri.parse('https://www.themealdb.com/api/json/v1/1/search.php?s=$query')
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final meals = (jsonResponse['meals'] as List?)
            ?.map((meal) => Meal.fromJson(meal))
            .toList() ?? [];
        emit(SearchSuccess(meals));
      } else {
        emit(SearchError('Failed to load search results'));
      }
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _searchSubscription?.cancel();
    _debounce?.cancel();
    _searchController.close();
    return super.close();
  }
}