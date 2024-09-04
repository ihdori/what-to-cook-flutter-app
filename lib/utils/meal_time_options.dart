// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:what2cooke/utils/colors.dart';

class MealTimeOptionsWidget extends StatelessWidget {
  MealTimeOptionsWidget({
    Key? key,
    required this.isDinner,
    required this.isLunch,
    required this.isBreakfast,
    required this.breakfastChanger,
    required this.dinnerChanger,
    required this.lunchChanger,
  }) : super(key: key);
  static const double largeMealTimeTextSize = 36;
  static const double smallMealTimeTextSize = 24;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight medium = FontWeight.w500;
  final bool isDinner;
  final bool isLunch;
  final bool isBreakfast;
  Function dinnerChanger;
  Function lunchChanger;
  Function breakfastChanger;
  @override
  Widget build(
    BuildContext context,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: () {
            dinnerChanger();
          },
          child: Text(
            'العشاء',
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontSize:
                  isDinner ? largeMealTimeTextSize : smallMealTimeTextSize,
              color: isDinner ? orangeRed : gray,
              fontWeight: isDinner ? bold : medium,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            lunchChanger();
          },
          child: Text(
            'الغداء',
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontSize: isLunch ? largeMealTimeTextSize : smallMealTimeTextSize,
              color: isLunch ? orangeRed : gray,
              fontWeight: isLunch ? bold : medium,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            breakfastChanger();
          },
          child: Text(
            'الريوكَ',
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontSize:
                  isBreakfast ? largeMealTimeTextSize : smallMealTimeTextSize,
              color: isBreakfast ? orangeRed : gray,
              fontWeight: isBreakfast ? bold : medium,
            ),
          ),
        ),
      ],
    );
  }
}
