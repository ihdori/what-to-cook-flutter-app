import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:what2cooke/providers/meal_region_controler_provider.dart';
import 'package:what2cooke/providers/meal_time_provider.dart';
import 'package:what2cooke/utils/colors.dart';
import 'package:what2cooke/utils/food_type_button.dart';
import 'package:what2cooke/utils/meal_time_options.dart';
import 'package:what2cooke/utils/what_to_eat_button.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedMealTime = ref.watch(mealTimeProvider);
    final isIraqiFoodTypeSelected =
        ref.watch(iraqiMealRegionControllerProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'images/bg_pattren_1.jpg',
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(0.1),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'الوجبة:',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontSize: 24,
                  color: turquois,
                  fontWeight: FontWeight.w500,
                ),
              ),
              MealTimeOptionsWidget(
                isBreakfast: selectedMealTime.isBreakfastSelected,
                isDinner: selectedMealTime.isDinnerSelected,
                isLunch: selectedMealTime.isLunchSelected,
                dinnerChanger: () {
                  ref.read(mealTimeProvider.notifier).changeToDinner();
                },
                lunchChanger: () {
                  ref.read(mealTimeProvider.notifier).changeToLunch();
                },
                breakfastChanger: () {
                  ref.read(mealTimeProvider.notifier).changeToBrakFast();
                },
              ),
              const SizedBox(
                height: 75,
              ),
              DottedBorder(
                color: orangeRed,
                borderPadding: const EdgeInsets.all(2),
                dashPattern: const [6, 2],
                radius: const Radius.circular(24),
                borderType: BorderType.RRect,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(12),
                  alignment: Alignment.bottomCenter,
                  width: MediaQuery.of(context).size.width - 170,
                  height: MediaQuery.of(context).size.width / 3.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'نوع الأكل',
                        style: TextStyle(
                          color: turquois,
                          fontSize: 16,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        textDirection: TextDirection.rtl,
                        children: [
                          FoodTypeButton(
                            text: '🇮🇶 عراقـي',
                            isSelected: isIraqiFoodTypeSelected,
                            onTap: () {
                              ref
                                  .read(iraqiMealRegionControllerProvider
                                      .notifier)
                                  .update((state) => true);
                            },
                          ),
                          FoodTypeButton(
                            text: '🌍 عالـمي',
                            isSelected: !isIraqiFoodTypeSelected,
                            onTap: () {
                              ref
                                  .read(iraqiMealRegionControllerProvider
                                      .notifier)
                                  .update((state) => false);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const WhatToEatButton(),
            ],
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height / 28,
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.2,
              height: MediaQuery.of(context).size.width / 7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Powered By:'),
                  SizedBox(
                      width: MediaQuery.of(context).size.width / 5,
                      child: Image.asset('images/ihdori.png')),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    '© جميع الحقوق محفوظة ',
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
