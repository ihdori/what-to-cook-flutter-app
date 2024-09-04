import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:what2cooke/functions/random_choice.dart';
import 'package:what2cooke/providers/meal_provider.dart';

class TestScreen extends ConsumerWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mealData = ref.watch(mealProvider);
    return Scaffold(
      body: mealData.when(
        data: (data) {
          return Center(
            child:
                Container(padding: EdgeInsets.all(20), child: Text(' ${data}')),
          );
        },
        error: (error, stackTrace) {
          print(error);
          return Center(child: Text(Exception(error).toString()));
        },
        loading: () {
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
