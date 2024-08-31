import 'package:flutter_riverpod/flutter_riverpod.dart';

class MealTimeSelected {
  bool isBreakfastSelected;
  bool isLunchSelected;
  bool isDinnerSelected;

  MealTimeSelected(
      {required this.isBreakfastSelected,
      required this.isLunchSelected,
      required this.isDinnerSelected});
}

class MealTimeSelectedState extends StateNotifier<MealTimeSelected> {
  MealTimeSelectedState()
      : super(MealTimeSelected(
            isBreakfastSelected: false,
            isLunchSelected: true,
            isDinnerSelected: false));

  void changeToDinner() {
    state = MealTimeSelected(
        isBreakfastSelected: false,
        isLunchSelected: false,
        isDinnerSelected: true);
  }

  void changeToLunch() {
    state = MealTimeSelected(
        isBreakfastSelected: false,
        isLunchSelected: true,
        isDinnerSelected: false);
  }

  void changeToBrakFast() {
    state = MealTimeSelected(
        isBreakfastSelected: true,
        isLunchSelected: false,
        isDinnerSelected: false);
  }
}
