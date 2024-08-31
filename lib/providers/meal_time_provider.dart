import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:what2cocke/functions/meal_time_selected.dart';

final mealTimeProvider =
    StateNotifierProvider<MealTimeSelectedState, MealTimeSelected>((ref) {
  return MealTimeSelectedState();
});
